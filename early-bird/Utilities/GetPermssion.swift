//
//  GetPermssion.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/24/25.
//
import SwiftUI
import Combine
import UserNotifications
import FamilyControls


class GetPermission: ObservableObject {
    
    /// 알림 권한 요청
    func requestNotificationPermission() async {
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

    
    // family control 권한 요청
    func requestFamilyControlsPermission() async {
        _ = await AppLimiter.shared.requestAuthorization()
    }

}

