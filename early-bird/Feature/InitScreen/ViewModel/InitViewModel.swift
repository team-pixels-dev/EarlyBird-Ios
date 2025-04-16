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
    @AppStorage("isFamilyControlsRequested") private var isFamilyControlsRequested: Bool = false
    @AppStorage("isNotificationRequested") private var isNotificationRequested: Bool = false
    
    private var getPermssion = GetPermission()

//    init() {
//        Task{
//            if !isFamilyControlsRequested {
//                await getPermssion.requestFamilyControlsPermission()
//                self.isFamilyControlsRequested = true
//            }
//            if !isNotificationRequested {
//                await getPermssion.requestNotificationPermission()
//                self.isNotificationRequested = true
//            }
//        }
//    }
    
    func sendVisitLog() {
        let visitData = Visit(clientId: ClientIDManager.getClientID())
        
        sendPostRequest(to: "/api/v1/log/visit-event", with: visitData){_ in}
    }

    /// 앱 실행 후 초기 동작 (스플래시뷰 -> 메인뷰 전환)
    func handleAppLaunch() {
        sendVisitLog()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                self.showMainView = true
            }
        }
    }
}
