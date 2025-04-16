//
//  ContentView.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/18/25.
//

import SwiftUI
//import Firebase

struct InitView: View {
    @StateObject private var viewModel = InitViewModel()
    @EnvironmentObject var appStateManager: AppStateManager
    @AppStorage("isOnboardingShown") private var isOnboardingShown: Bool = false
//    init() {
//        FirebaseApp.configure()
//    }

    var body: some View {
        NavigationView {
            if viewModel.showMainView {
                if isOnboardingShown {
                    MainView()
                } else {
                    OnboardContainerView()
                }
            } else {
                SplashView()
                    .onAppear {
                        viewModel.handleAppLaunch()
                    }
            }
        }
    }
}

#Preview {
    InitView()
}
