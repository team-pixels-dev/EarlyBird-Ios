//
//  web_color.swift
//  early-bird
//
//  Created by JAYOU KOO on 2/24/25.
//

import SwiftUI

extension Color {
    init(light: Color, dark: Color) {
            self.init(UIColor(light: UIColor(light), dark: UIColor(dark)))
    }
}


extension UIColor {
    convenience init(light: UIColor, dark: UIColor) {
        self.init { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return dark
            case .light, .unspecified:
                return light
            @unknown default:
                return light
            }
        }
    }
}
