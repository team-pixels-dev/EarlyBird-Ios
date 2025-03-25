//
//  ShakeDetectingWindow.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/25/25.
//

import UIKit
import SwiftUI
import Foundation

extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: .deviceDidShakeNotification, object: nil)
        }
    }
}

extension Notification.Name {
    static let deviceDidShakeNotification = Notification.Name("deviceDidShakeNotification")
}
