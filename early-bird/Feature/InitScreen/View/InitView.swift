//
//  ContentView.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/18/25.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct InitView: View {
    @StateObject private var viewModel = InitViewModel()
    @EnvironmentObject var appStateManager: AppStateManager
    @AppStorage("isOnboardingShown") private var isOnboardingShown: Bool = false
    
    @UIApplicationDelegateAdaptor var delegate: CustomAppDelegate
    
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

class CustomAppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      FirebaseApp.configure()
      return true
    }
}
