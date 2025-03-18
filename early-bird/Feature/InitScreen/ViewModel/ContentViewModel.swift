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
class ContentViewModel: ObservableObject {
    @Published var showMainView = false
    @AppStorage("isFamilyControlsRequested") private var isFamilyControlsRequested: Bool = false

    init() {
        Task{
            await requestFamilyControlsPermission()
            await requestNotificationPermission()
        }
    }

    /// 알림 권한 요청
    private func requestNotificationPermission() async {
        do {
            let granted = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
            if granted {
                print("✅ 알림 권한 허용됨")
            } else {
                print("⚠️ 알림 권한 거부됨")
            }
        } catch {
            print("🔴 알림 권한 요청 오류: \(error.localizedDescription)")
        }
    }
    
    private func requestFamilyControlsPermission() async {
        if !isFamilyControlsRequested {
            AppLimiter.shared.requestAuthorization()
            DispatchQueue.main.async {
                self.isFamilyControlsRequested = true
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
