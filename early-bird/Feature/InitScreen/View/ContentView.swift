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
                        Group{
                            MainView()
                        }
                    }
                    .navigationBarBackButtonHidden()
                } else {
                    Text("navigateToScreen : ")
//                    SplashView()
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
