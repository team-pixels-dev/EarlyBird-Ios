//
//  OnboardingCoordinator.swift
//  early-bird
//
//  Created by JAYOU KOO on 4/14/25.
//


import Foundation
import SwiftUI

class OnboardingCoordinator: ObservableObject {
    @Published var currentStep: OnboardingStep = .page0

    func goToNext() {
        HapticFeedbackManager.mediumImpact()
        switch currentStep {
        case .page0:
            currentStep = .page1
        case .page1:
            currentStep = .page2
        case .page2:
            currentStep = .page3
        case .page3:
            currentStep = .page4
        case .page4:
            currentStep = .page5
        case .page5:
            currentStep = .done
        default:
            break
        }
    }
}
