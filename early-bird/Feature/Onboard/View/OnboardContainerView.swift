//
//  OnboardContainerView.swift
//  early-bird
//
//  Created by JAYOU KOO on 4/14/25.
//

import SwiftUICore
import SwiftUI

struct OnboardContainerView: View {
    @StateObject private var coordinator = OnboardingCoordinator()

    var body: some View {
        switch coordinator.currentStep {
        case .page1:
            Onboard1View(viewModel: Onboard1ViewModel(coordinator: coordinator))
        case .page2:
            Onboard2View(viewModel: Onboard2ViewModel(coordinator: coordinator))
        case .page3:
            Onboard3View(viewModel: Onboard3ViewModel(coordinator: coordinator))
        case .page4:
            Onboard4View(viewModel: Onboard4ViewModel(coordinator: coordinator))
        case .done:
            MainView()
        }
    }
}
