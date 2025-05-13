//
//  MainViewModel.swift
//  early-bird
//
//  Created by JAYOU KOO on 5/12/25.
//


import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
    @Published var gotoTimerView = false
    @Published var gotoCompleteView = false
    @Published var gotoSettingView = false
    
    @Published var isVisible = false
    
    @Published var appStateManager = AppStateManager.shared
    
    func handleOnAppear() {
        isVisible = true
        
        guard appStateManager.lastAppState == .timerStarted else { return }
        
        let timeRemaining = Int(appStateManager.timerEndTime.timeIntervalSince(Date()) * 1000)
        if timeRemaining > 0 {
            gotoTimerView = true
        } else {
            gotoCompleteView = true
        }
    }
}
