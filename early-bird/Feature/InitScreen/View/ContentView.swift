//
//  ContentView.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/18/25.
//


import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        
            ZStack {
                if viewModel.showMainView {
                    NavigationView {
                        Group {
                            switch viewModel.navigateToScreen {
                            case "timerEndNotification":
                                CompleteView()
                                    .onAppear { viewModel.navigateToScreen = "" } // 값 초기화
                            default:
                                MainView()
                            }
                        }
                    }
                    .navigationBarBackButtonHidden()
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
    ContentView()
}
