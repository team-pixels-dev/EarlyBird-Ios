//
//  TimerViewModel.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/9/25.
//
import SwiftUI
import UIKit
import Combine
import UserNotifications

class TimerViewModel: ObservableObject {
    @Published var timeRemaining: Int
    @Published var timerActive: Bool = false
    @Published var showNextView: Bool = false
    @AppStorage("navigateToScreen") private var navigateToScreen: String = ""
    
    private var timer: Timer?
    private let model = TimerModel()
    
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    init() {
        feedbackGenerator.prepare()
        self.timeRemaining = model.initialTime
    }
    
    var formattedTime: String {
        let minutes = (timeRemaining % 360000) / 6000
        let seconds = (timeRemaining % 6000) / 100
        return String(format: "%02d:%02d.", minutes, seconds)
    }
    
    var formattedTimeMs: String {
        let milliseconds = timeRemaining % 100
        return String(format: "%02d", milliseconds)
    }
    
    func startTimer() {
        timer?.invalidate()
        timeRemaining = model.initialTime
        timerActive = true
        
        scheduleNotification(identifier: "timerEndNotification")
        self.feedbackGenerator.impactOccurred()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
                
                // 매 1초(즉, 100 단위)마다 진동 발생
                if self.timeRemaining % 100 == 0 {
                    self.feedbackGenerator.impactOccurred()
                }
            } else {
                self.stopTimer()
                self.showNextView = true
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timerActive = false
    }
    
    // 🔹 2. 2분 뒤 알림 예약
    func scheduleNotification(identifier: String) {
            let content = UNMutableNotificationContent()
            content.title = "⏰ 타이머 종료!"
            content.body = "2분이 지났어요. 다음 단계로 이동하세요."
            content.sound = .default

            let trigger = UNTimeIntervalNotificationTrigger(
                timeInterval: TimeInterval(model.initialTime / 100), repeats: false
            )
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("🔴 알림 예약 실패: \(error.localizedDescription)")
                } else {
                    print("✅ \(identifier) 알림 예약 완료")
                }
            }
        }
}
