//
//  Onboard2ViewModel.swift
//  early-bird
//
//  Created by JAYOU KOO on 4/14/25.
//


import Foundation
import SwiftUI

class Onboard5ViewModel: ObservableObject {
    @Published var visibleCount = 0
    @Published var showBlock1 = false
    @Published var showBlock2 = false
    @Published var showBlock3 = false
    @Published var showBlock4 = false
    @Published var notiAccessClicked = false
    @AppStorage("isNotificationRequested") private var isNotificationRequested: Bool = false
    @AppStorage("isOnboardingShown") private var isOnboardingShown: Bool = false
    
    private var getPermssion = GetPermission()

    private let coordinator: OnboardingCoordinator

    init(coordinator: OnboardingCoordinator) {
        self.coordinator = coordinator
    }


    func startAnimationSequence() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.easeOut(duration: 0.5)) {
                self.showBlock1 = true
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            withAnimation(.easeOut(duration: 0.5)) {
                self.showBlock2 = true
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            withAnimation(.easeOut(duration: 0.5)) {
                self.showBlock3 = true
            }
        }
    }
    
    // 온보딩이 완료되면, FCM 설정
    func configureFCMIfAuthorized() {
        print("🟡 configureFCMIfAuthorized called")
            
        if let delegate = AppDelegate.instance {
            print("✅ AppDelegate.instance 접근 성공")
            delegate.configurePushIfAuthorized(application: UIApplication.shared)
        } else {
            print("❌ AppDelegate.instance 접근 실패")
        }
    }

    // 알림 권한을 획득한 후 온보딩을 종료하고 메인 페이지로 이동
    func getPermison() {
        withAnimation(.easeOut(duration: 0.5)) {
            self.showBlock4 = true
        }
        notiAccessClicked = true
        HapticFeedbackManager.triggerHapticFeedbackPattern()
        
        Task{
            if !isNotificationRequested {
                await getPermssion.requestNotificationPermission()
                await MainActor.run {
                    self.isNotificationRequested = true
                }
            }
            
            await MainActor.run {
                isOnboardingShown = true
                
                Task{
                    if await getPermssion.getNofiPermissonState() == .authorized {
                        // 로컬 알림 예약
                        ScheduleNotification.shared.scheduleMorningNoti()
                        ScheduleNotification.shared.scheduleNightNoti()
                    }
                }
                
                configureFCMIfAuthorized() // FCM 설정(알림 권한 허용시만 적용됨)
                coordinator.goToNext()
            }
        }
    }
}
