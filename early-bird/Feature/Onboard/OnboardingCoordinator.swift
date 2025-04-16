//
//  OnboardingCoordinator.swift
//  early-bird
//
//  Created by JAYOU KOO on 4/14/25.
//


import Foundation
import SwiftUI

class OnboardingCoordinator: ObservableObject {
    @Published var currentStep: OnboardingStep = .page1

    func goToNext() {
        switch currentStep {
        case .page1:
            currentStep = .page2
        case .page2:
            currentStep = .page3
        case .page3:
            currentStep = .page4
        case .page4:
            currentStep = .done
        default:
            break
        }
    }
}
