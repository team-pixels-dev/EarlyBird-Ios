//
//  ContentView.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/18/25.
//

import SwiftUI

struct InitView: View {
    @StateObject private var viewModel = InitViewModel()
    @EnvironmentObject var appStateManager: AppStateManager
    @AppStorage("isOnboardingShown") private var isOnboardingShown: Bool = false

    var body: some View {
        NavigationView {
            if viewModel.showMainView {
                if isOnboardingShown {
                    MainView()
                } else {
                    Onboard_1View()
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
