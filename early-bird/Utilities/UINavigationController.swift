//
//  controllBackGesture.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/4/25.
//
import SwiftUI
import UIKit

final class PopGestureManager {

    // Singleton 객체 생성
    static let shared = PopGestureManager()
    private init() {}
    
    // 뒤로가기 제스처를 허용하는지 확인 변수
    private(set) var isAllowPopGesture = true
    
    // 뒤로가기 제스처를 허용하는 변수 업데이트
    func updateAllowPopGesture(_ bool: Bool) {
        isAllowPopGesture = bool
    }
}


extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    // isAllowPopGesture == true, viewControllers.count가 2 이상일 때
        return PopGestureManager.shared.isAllowPopGesture && viewControllers.count > 1
    }
}

struct PopGestureDisabledViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .task {
                PopGestureManager.shared.updateAllowPopGesture(false)
            }
            .onDisappear {
                PopGestureManager.shared.updateAllowPopGesture(true)
            }
    }
}

extension View {
    func popGestureDisabled() -> some View {
        modifier(PopGestureDisabledViewModifier())
    }
}
