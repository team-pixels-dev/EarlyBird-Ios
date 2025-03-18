//
//  HapticFeedbackManager.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/18/25.
//


import UIKit

final class HapticFeedbackManager {
    
    /// 가벼운 진동
    static func lightImpact() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
    }
    
    /// 중간 강도의 진동
    static func mediumImpact() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }
    
    /// 강한 진동
    static func heavyImpact() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        generator.impactOccurred()
    }
    
    /// 선택 변경 진동
    static func selectionChanged() {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
    
    /// 알림 피드백 (성공, 경고, 오류)
    static func notification(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(type)
    }
    
    /// 🔹 **복합적인 진동 패턴**
    static func triggerHapticFeedbackPattern() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            mediumImpact() // 중간 강도의 진동
//        }
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//            heavyImpact()  // 강한 진동
//        }
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//            selectionChanged() // 선택 피드백
//        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            notification(.success) // 성공 알림 피드백
        }
    }
}
