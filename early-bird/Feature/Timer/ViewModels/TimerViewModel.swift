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
    @Published var endTime: Date
    @Published var timerActive: Bool = false
    @Published var showNextView: Bool = false
    
    private var timer: Timer?
    private let model = TimerModel()
    
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    init() {
        feedbackGenerator.prepare()
        self.timeRemaining = model.initialTime
        self.endTime = Date().addingTimeInterval(Double(model.initialTime) / 1000)
    }
    
    var formattedTime: String {
        let minutes = (timeRemaining / 60000) % 60
        let seconds = (timeRemaining / 1000) % 60
        return String(format: "%02d:%02d.", minutes, seconds)
    }
    
    var formattedTimeMs: String {
        let milliseconds = timeRemaining % 1000
        return String(format: "%02d", milliseconds / 10)
    }
    
    func excuteTimer() {
        print("🔹 excuteTimer() 실행됨")
        
        // 앱 잠금 시간이 최소 900초(15분)이므로 최소 900초 이상 잠금 설정
        AppLimiter.shared.startBlockingAllApps(for: min(TimeInterval(model.initialTime / 1000), 900))
        
        startTimer()
        
        clickLog()
    }
    
    func startTimer() {
        timer?.invalidate()
        timeRemaining = model.initialTime
        var seconds = (timeRemaining % 60000) / 1000
        self.endTime = Date().addingTimeInterval(Double(model.initialTime) / 1000)
        timerActive = true
        
        scheduleNotification(identifier: "timerEndNotification")
    
        self.feedbackGenerator.impactOccurred()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            if self.timeRemaining > 0 {
//              self.timeRemaining -= 1
                self.timeRemaining = max(Int(self.endTime.timeIntervalSince(Date()) * 1000), 0)
                
                let newSeconds = (timeRemaining % 60000) / 1000
                
                // 매 1초마다 진동 발생
                if newSeconds != seconds {
                    seconds = newSeconds
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
            content.title = "계속 몰입해봐요❗️❗️❗️"
            content.body = "그래도 다른 앱 차단을 풀고 싶다면,\n 얼리버드 앱에 접속해주세요!"
            content.sound = .default

            let trigger = UNTimeIntervalNotificationTrigger(
                timeInterval: TimeInterval(model.initialTime / 1000), repeats: false
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
    
    func clickLog(){
        let ClickLogData = ClickLogJson(
            clientId: ClientIDManager.getClientID(),
            clickType: "timer-start-button-click",
            clickTime: formatDate(Date())
        )
        
        sendPostRequest(to: "/api/v1/log/click", with: ClickLogData){_ in }
    }
}
