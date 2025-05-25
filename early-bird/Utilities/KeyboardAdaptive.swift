//
//  KeyboardAdaptive.swift
//  early-bird
//
//  Created by JAYOU KOO on 5/25/25.
//


import SwiftUI
import Combine

// 1) 키보드 높이를 퍼블리셔로 제공하는 Helper
extension Publishers {
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
            .map { $0.height }

        let willHide = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }

        // merge(with:)는 서로 다른 Upstream 타입도 허용합니다.
        return willShow
            .merge(with: willHide)
            .eraseToAnyPublisher()
    }
}


// 2) 키보드 어댑티브 Modifier
struct KeyboardAdaptive: ViewModifier {
    @State private var currentHeight: CGFloat = 0
    private let animation: Animation = .easeOut(duration: 0.25)
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, currentHeight)
            .animation(animation, value: currentHeight)
            .onReceive(Publishers.keyboardHeight) { height in
                self.currentHeight = height
            }
    }
}

extension View {
    func keyboardAdaptive() -> some View {
        self.modifier(KeyboardAdaptive())
    }
}
