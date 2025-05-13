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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            InitView()
        }.environment(\.theme, Theme())
    }
}
