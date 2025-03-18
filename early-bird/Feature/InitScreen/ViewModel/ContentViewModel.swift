//
//  ContentViewModel.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/18/25.
//


import SwiftUI
import Combine
import UserNotifications

class ContentViewModel: ObservableObject {
    @Published var showMainView = false
    @AppStorage("navigateToScreen") var navigateToScreen: String = ""

    init() {
        requestNotificationPermission()
    }

    /// 알림 권한 요청
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("🔴 알림 권한 요청 오류: \(error.localizedDescription)")
            } else if granted {
                print("✅ 알림 권한 허용됨")
            } else {
                print("⚠️ 알림 권한 거부됨")
            }
        }
    }

    /// 앱 실행 후 초기 동작 (스플래시뷰 -> 메인뷰 전환)
    func handleAppLaunch() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
                self.showMainView = true
            }
        }
    }
}
