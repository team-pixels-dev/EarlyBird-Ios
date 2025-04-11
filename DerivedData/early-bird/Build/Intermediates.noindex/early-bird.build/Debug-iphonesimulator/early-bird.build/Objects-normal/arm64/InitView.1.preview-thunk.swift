import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Users/jayoukoo/Documents/etc/team_pixel/early-bird/early-bird/early-bird/Feature/InitScreen/View/InitView.swift", line: 1)
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

    var body: some View {
        NavigationView {
            if viewModel.showMainView {
                MainView()
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
