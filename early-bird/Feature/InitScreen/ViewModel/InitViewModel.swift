//
//  ContentViewModel.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/18/25.
//

import SwiftUI
import Combine
import UserNotifications
import FirebaseAnalytics

@MainActor
class InitViewModel: ObservableObject {
    @Published var showMainView = false
    @AppStorage("isOnboardingShown") private var isOnboardingShown: Bool = false
    @AppStorage("isTeamMember") private var isTeamMember: Bool = false

    /// 앱 실행 후 초기 동작 (스플래시뷰 -> 메인뷰 전환)
    func handleAppLaunch() {
        if isOnboardingShown {
            
            // 팀 맴버가 아닌 경우에만 데이터 수집
            if isTeamMember {
                Analytics.setAnalyticsCollectionEnabled(false)
            } else {
                // 온보딩 이후에는 앱 실행시 즉시 visitLog 전송
                sendVisitLog()
                
                // Amplitude 설정
                AmplitudeManager.shared.configureAfterOnboarding(isTeamMember: isTeamMember)
                AmplitudeManager.shared.trackEvent("app_launch", properties: [
                    "is_onboarding_shown": isOnboardingShown,
                    "is_team_member": isTeamMember
                ])
            }
            
            // 온보딩 이후 최초 실행 시에만 알림 예약
            
            ScheduleNotification.shared.scheduleMorningNoti()
            ScheduleNotification.shared.scheduleNightNoti()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                self.showMainView = true
            }
        }
    }
}

func sendVisitLog() {
    let visitData = Visit(clientId: ClientIDManager.getClientID())
    
    sendPostRequest(to: "/api/v1/log/visit-event", with: visitData){_ in}
}
