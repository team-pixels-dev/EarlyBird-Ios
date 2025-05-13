//
//  Appdelegate.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/18/25.
//
import UIKit
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseAnalytics
import FirebaseMessaging


class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    static var instance: AppDelegate?
    @AppStorage("isOnboardingShown") private var isOnboardingShown: Bool = false
    
    func application(_ application: UIApplication,
                       didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        AppDelegate.instance = self
        
        FirebaseApp.configure()
        // 사용자 동의 후 자동 데이터 수집 활성화
        // Analytics.setAnalyticsCollectionEnabled(true)
        
        // 온보딩 이후 FCM 설정
        if isOnboardingShown {
            configurePushIfAuthorized(application: application)
        }
        
        return true
    }
    
    func application(_ application: UIApplication,
                         didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            Messaging.messaging().apnsToken = deviceToken
        }
    
    func configurePushIfAuthorized(application: UIApplication) {
        print("✅ AppDelegate.configurePushIfAuthorized called")

        UNUserNotificationCenter.current().getNotificationSettings { settings in
            // 알림 권한이 허용된 경우만 설정
            if settings.authorizationStatus == .authorized || settings.authorizationStatus == .provisional {
                DispatchQueue.main.async {
                    // 앱이 수신한 푸시 알림(또는 로컬 알림)에 대해 직접 처리할 수 있도록 알림의 델리게이트(delegate)를 설정
                    UNUserNotificationCenter.current().delegate = self
                    // 앱이 Apple Push Notification service(APNs)에 푸시 알림을 수신할 수 있도록 등록
                    application.registerForRemoteNotifications()
                    // Firebase Cloud Messaging(FCM)의 메시지 관련 이벤트를 처리하기 위한 델리게이트(delegate)를 설정
                    Messaging.messaging().delegate = self
                    print("FCM 설정됨")
                }
            } else {
                print("🔕 알림 권한이 비허용 상태입니다.")
            }
        }
    }

    // 포어그라운드 푸시 수신 처리
    func userNotificationCenter(_ center: UNUserNotificationCenter,
       willPresent notification: UNNotification,
       withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("FCM Token: \(fcmToken ?? "")")
        // 서버에 FCM 토큰 보내기 등 추가 처리
    }
}
