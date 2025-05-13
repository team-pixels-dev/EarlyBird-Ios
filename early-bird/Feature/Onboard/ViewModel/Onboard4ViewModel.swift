//
//  Onboard2ViewModel.swift
//  early-bird
//
//  Created by JAYOU KOO on 4/14/25.
//


import Foundation
import SwiftUI

class Onboard4ViewModel: ObservableObject {
    @Published var inputText: String = UserInputManager.shared.resolutionText
    @Published var visibleCount = 0
    @Published var showBlock1 = false
    @Published var showBlock2 = false
    @Published var showBlock3 = false
    @Published var screenTimeAccessClicked = false
    @AppStorage("isFamilyControlsRequested") private var isFamilyControlsRequested: Bool = false
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

    // 스크린타임 API 권한과 알림 권한을 획득한 후 온보딩을 종료하고 메인 페이지로 이동
    func getPermison() {
        screenTimeAccessClicked = true
        HapticFeedbackManager.triggerHapticFeedbackPattern()
        
        Task{
            if !isFamilyControlsRequested {
                await getPermssion.requestFamilyControlsPermission()
                await MainActor.run {
                    self.isFamilyControlsRequested = true
                }
            }
            if !isNotificationRequested {
                await getPermssion.requestNotificationPermission()
                await MainActor.run {
                    self.isNotificationRequested = true
                }
            }
            
            await MainActor.run {
                isOnboardingShown = true
                configureFCMIfAuthorized() // FCM 설정(알림 권한 허용시만 적용됨)
                coordinator.goToNext()
            }
            
        }
    }
}
