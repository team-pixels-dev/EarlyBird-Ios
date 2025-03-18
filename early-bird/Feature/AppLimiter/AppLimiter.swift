//
//  FamilyViewModel.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/9/25.
//
import Foundation
import FamilyControls
import ManagedSettings
import DeviceActivity

class AppLimiter: ObservableObject {
    
    // 싱글톤 인스턴스
    static let shared = AppLimiter()
    
    private let familyCenter = AuthorizationCenter.shared
    private let store = ManagedSettingsStore()
    private let deviceActivityCenter = DeviceActivityCenter()
    
    private init() {} // 외부에서 인스턴스 생성 방지
    
    // 모든 앱 차단 (사용자가 시간 설정 가능)
    func startBlockingAllApps(for duration: TimeInterval) {
        print("차단 시도")

        store.shield.applicationCategories = .all()
        
        let now = Calendar.current.dateComponents([.hour, .minute], from: Date())
        let endTime = Calendar.current.dateComponents([.hour, .minute], from: Date().addingTimeInterval(duration))
        
        let schedule = DeviceActivitySchedule(
            intervalStart: now,
            intervalEnd: endTime,
            repeats: false
        )
        
        do {
            try deviceActivityCenter.startMonitoring(DeviceActivityName("GlobalAppLimit"), during: schedule)
            print("모든 앱이 \(Int(duration))초 동안 차단됩니다.")
        } catch {
            print("차단 스케줄 설정 중 오류 발생: \(error)")
        }
    }
    
    // 차단 해제
    func stopBlocking() {
        store.shield.applications = Set<ApplicationToken>() // 빈 Set으로 초기화
        store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.none // 카테고리 차단도 해제
        print("앱 차단이 해제되었습니다.")
    }
    
    // FamilyControls 권한 요청
    func requestAuthorization() {
        Task {
            do {
                try await familyCenter.requestAuthorization(for: .individual)
                print("FamilyControls 권한 승인됨.")
            } catch {
                print("FamilyControls 권한 요청 실패: \(error)")
            }
        }
    }
}
