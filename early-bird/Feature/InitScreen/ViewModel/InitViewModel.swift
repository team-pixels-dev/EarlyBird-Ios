//
//  ContentViewModel.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/18/25.
//

import SwiftUI
import Combine
import UserNotifications

@MainActor
class InitViewModel: ObservableObject {
    @Published var showMainView = false
    @AppStorage("isOnboardingShown") private var isOnboardingShown: Bool = false
    
    func sendVisitLog() {
        let visitData = Visit(clientId: ClientIDManager.getClientID())
        
        sendPostRequest(to: "/api/v1/log/visit-event", with: visitData){_ in}
    }

    /// 앱 실행 후 초기 동작 (스플래시뷰 -> 메인뷰 전환)
    func handleAppLaunch() {
        sendVisitLog()
        
        if isOnboardingShown {
            // 최초 실행 시에만 알림 예약
            
            // 09시 알림 예약
            ScheduleNotification.shared.scheduleNotifications(
                for: [1,2,3,4,5,6,7],
                hour: 9,
                minute: 0,
                noti_title: "morning_noti_title",
                noti_body: "morning_noti_body",
                type: "morning"
            )
            
            // 23시 알림 예약
            ScheduleNotification.shared.scheduleNotifications(
                for: [1,2,3,4,5,6,7],
                hour: 23,
                minute: 0,
                noti_title: "evening_noti_title",
                noti_body: "evening_noti_body",
                type: "evening"
            )
            print("📅 알림 예약 완료")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                self.showMainView = true
            }
        }
    }
}
