//
//  GetPermssion.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/24/25.
//

// 앱 권한 설정

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
    
    
    // 알림 권한 상태를 확인한 후, 적절한 동작 수행
    @MainActor
    func checkAndRequestNotificationPermission() async {
        switch await getNofiPermissonState() {
        case .notDetermined:
            await requestNotificationPermission()
        case .denied:
            // 이전에 거절한 경우 설정 앱으로 유도
            print("⚠️ 알림 권한이 거부되어 설정 앱으로 유도 필요")
            
            if let url = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(url) {
                await UIApplication.shared.open(url)
            }
        case .authorized, .provisional, .ephemeral:
            print("✅ 이미 알림 권한 있음")
        @unknown default:
            break
        }
    }
    
    // 알림 권한 상태 확인
    func getNofiPermissonState() async -> UNAuthorizationStatus {
        let center = UNUserNotificationCenter.current()
        let settings = await center.notificationSettings()
        
        return settings.authorizationStatus
    }

}

