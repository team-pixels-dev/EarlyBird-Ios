//
//  ContentView.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/18/25.
//

import SwiftUI

struct InitView: View {
    @StateObject private var viewModel = InitViewModel()
    @AppStorage("isOnboardingShown") private var isOnboardingShown: Bool = false
    
    @State private var showAlert = false
    @State private var showPasswordPrompt = false
    
    private let shakePublisher = NotificationCenter.default.publisher(for: .deviceDidShakeNotification)
    
    var body: some View {
        NavigationView {
            if viewModel.showMainView {
                if isOnboardingShown {
                    MainView()
                } else {
                    OnboardContainerView()
                }
            } else {
                OnboardView()
                    .onAppear {
                        viewModel.handleAppLaunch()
                    }
            }
        }
        .onReceive(shakePublisher) { _ in
            showAlert = true
        }
        .teamMemberAlert(isPresented: $showAlert, showPasswordPrompt: $showPasswordPrompt)
        .sheet(isPresented: $showPasswordPrompt) {
            PasswordPromptSheet(isPresented: $showPasswordPrompt)
        }
    }
}

#Preview {
    InitView()
}
