//
//  BackgroundModifier.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/25/25.
//

// 배경색 지정

import SwiftUI

struct BackgroundModifier: ViewModifier {
    let color: Color
    
    init(color: Color = Theme.appBackgroundColor) {
        self.color = color
    }
    
    func body(content: Content) -> some View {
        ZStack {
            color.ignoresSafeArea(edges: .all)
            content
        }
    }
}

extension View {
    func applyBackground() -> some View {
        self.modifier(BackgroundModifier())
    }
    
    func applyBackgroundWhite() -> some View {
        self.modifier(BackgroundModifier(color: Theme.brightTextColor))
    }
}
