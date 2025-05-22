//
//  AppLimiter.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/9/25.
//
import Foundation
import FamilyControls
import ManagedSettings
import DeviceActivity

class AppLimiter: ObservableObject {
    static let shared = AppLimiter()
    
    private let familyCenter = AuthorizationCenter.shared
    private let store = ManagedSettingsStore()
    private let deviceActivityCenter = DeviceActivityCenter()
    
    private var appStateManager = AppStateManager.shared
    
    private init() {}
    
    func isNotAuthorized() async -> Bool {
        let status = AuthorizationCenter.shared.authorizationStatus
        print("🔍 FamilyControls 현재 상태: \(status)")
        return status == .denied
    }
    
    // 개선된 권한 요청 메서드
    func requestAuthorization() async -> String {
        let currentStatus = familyCenter.authorizationStatus
        print("🔍 권한 요청 전 상태: \(currentStatus)")
        
        // 이미 승인된 경우
        if currentStatus == .approved {
            print("✅ 이미 FamilyControls 권한이 승인됨")
            return "success"
        }
        
        do {
            try await familyCenter.requestAuthorization(for: .individual)
            
            // 권한 요청 후 잠시 대기
            try await Task.sleep(nanoseconds: 500_000_000) // 0.5초 대기
            
            let newStatus = familyCenter.authorizationStatus
            print("🔍 권한 요청 후 상태: \(newStatus)")
            
            if newStatus == .approved {
                print("✅ FamilyControls 권한 승인됨")
                return "success"
            } else {
                print("❌ FamilyControls 권한 거부됨 또는 대기중")
                return "denied"
            }
        } catch {
            print("❌ FamilyControls 권한 요청 실패: \(error)")
            return "fail"
        }
    }
    
    // 권한 상태를 강제로 새로고침하는 메서드
    func refreshAuthorizationStatus() -> Bool {
        // 잠시 대기 후 상태 재확인
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let status = self.familyCenter.authorizationStatus
            print("🔄 권한 상태 새로고침: \(status)")
        }
        return familyCenter.authorizationStatus == .approved
    }
    
    // 앱 차단 메서드도 권한 체크 추가
    func startBlockingAllApps(for duration: TimeInterval) async {
        if await isNotAuthorized() {
            print("❌ FamilyControls 권한이 없어서 앱 차단 불가")
            return
        }
        
        print("🔒 앱 차단 시작")
        
        store.shield.applicationCategories = .all()
        
        let now = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
        let endTime = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date().addingTimeInterval(duration))
        
        print("시작 시간: \(now)")
        print("종료 시간: \(endTime)")
        
        let schedule = DeviceActivitySchedule(
            intervalStart: now,
            intervalEnd: endTime,
            repeats: false
        )
        
        do {
            try deviceActivityCenter.startMonitoring(
                DeviceActivityName("GlobalAppLimit"),
                during: schedule
            )
            print("✅ 모든 앱이 \(Int(duration)/60)분 동안 차단됩니다.")
        } catch {
            print("❌ 차단 스케줄 설정 중 오류 발생: \(error)")
        }
    }
    
    func stopBlocking() {
        store.shield.applications = Set<ApplicationToken>()
        store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.none
        deviceActivityCenter.stopMonitoring([DeviceActivityName("GlobalAppLimit")])
        print("🔓 앱 차단이 해제되고 모니터링도 중단되었습니다.")
    }
}
