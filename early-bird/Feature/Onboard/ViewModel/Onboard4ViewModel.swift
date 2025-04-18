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

    func getScreenTimePermison() {
        screenTimeAccessClicked = true
        HapticFeedbackManager.triggerHapticFeedbackPattern()
        
        Task{
            if !isFamilyControlsRequested {
                await getPermssion.requestFamilyControlsPermission()
                self.isFamilyControlsRequested = true
            }
            if !isNotificationRequested {
                await getPermssion.requestNotificationPermission()
                self.isNotificationRequested = true
            }
            isOnboardingShown = true
                        
            coordinator.goToNext()
            
        }
    }
}
