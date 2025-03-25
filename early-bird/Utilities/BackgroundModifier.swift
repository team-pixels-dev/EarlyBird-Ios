//
//  BackgroundModifier.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/25/25.
//

// 배경색 지정

import SwiftUI

struct BackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Theme.appBackgroundColor.ignoresSafeArea(edges: .all)
            content
        }
    }
}

extension View {
    func applyBackground() -> some View {
        self.modifier(BackgroundModifier())
    }
}
