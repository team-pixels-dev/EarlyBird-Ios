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
    
    // 싱글톤 인스턴스
    static let shared = AppLimiter()
    
    private let familyCenter = AuthorizationCenter.shared
    private let store = ManagedSettingsStore()
    private let deviceActivityCenter = DeviceActivityCenter()
    
    private var appStateManager = AppStateManager.shared
    
    private init() {} // 외부에서 인스턴스 생성 방지
    
    // 모든 앱 차단 (사용자가 시간 설정 가능)
   func startBlockingAllApps(for duration: TimeInterval) {
       print("차단 시도")
       
       store.shield.applicationCategories = .all()
       
       
       let now = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
       let endTime = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date().addingTimeInterval(duration))
       
       print("start time : " , now)
       print("end time : " , endTime)
       
       let schedule = DeviceActivitySchedule(
           intervalStart: now,
           intervalEnd: endTime,
           repeats: false
       )
       
       do {
           // during: schedule 을 인자로 받는데, 이는 모니터링과 관계가 있고 DeviceActivityName의 실행 종료 시점을 직접 제어하지는 않는다.
           try deviceActivityCenter.startMonitoring(
            DeviceActivityName("GlobalAppLimit"),
            during: schedule
           )
           print("모든 앱이 \(Int(duration)/60)분 동안 차단됩니다.")
       } catch {
           print("차단 스케줄 설정 중 오류 발생: \(error)")
       }
   }
    
    var isAuthorized: Bool {
           AuthorizationCenter.shared.authorizationStatus == .approved
    }

    
    // 차단 해제
    func stopBlocking() {
        store.shield.applications = Set<ApplicationToken>() // 빈 Set으로 초기화
        store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.none // 카테고리 차단도 해제
        deviceActivityCenter.stopMonitoring([DeviceActivityName("GlobalAppLimit")]) // 모니터링 중단
        print("앱 차단이 해제되고 모니터링도 중단되었습니다.")
    }
    
    // FamilyControls 권한 요청
    func requestAuthorization() async -> String {
        do {
            try await familyCenter.requestAuthorization(for: .individual)
            print("FamilyControls 권한 승인됨.")
            return "success"
        } catch {
            print("FamilyControls 권한 요청 실패: \(error)")
            return "fail"
        }
    }
}
