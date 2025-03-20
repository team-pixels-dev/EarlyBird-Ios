//
//  early_birdApp.swift
//  early-bird
//
//  Created by JAYOU KOO on 2/12/25.
//

import SwiftUI
import FamilyControls

@main
struct early_birdApp: App {
    @StateObject private var appStateManager = AppStateManager()
    
    var body: some Scene {
        WindowGroup {
            InitView()
                .environmentObject(appStateManager)
        }.environment(\.theme, Theme())
        
    }
}
