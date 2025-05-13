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
import FamilyControls

@MainActor
class TimerViewModel: ObservableObject {
    @Published var timeRemaining: Int
    @Published var endTime: Date
    @Published var timerActive: Bool = false
    @Published var showNextView: Bool = false
    @Published var showPermissionErrorMsgModal: Bool = false
    
    @AppStorage("isHapticsEnabled") var isHapticsDisabled: Bool = false
   
    private var dispatchTimer: DispatchSourceTimer?
    private let model = TimerModel()
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
    private let firstTouchfeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    private var appStateManager = AppStateManager.shared
    private var getPermission = GetPermission()
    
    init() {
        self.timeRemaining = model.initialTime
        self.endTime = Date().addingTimeInterval(Double(model.initialTime) / 1000)
        feedbackGenerator.prepare()
        
        Task{
            if(appStateManager.lastAppState == .timerStarted) {
                checkPermissionsAndStartTimer(autoStart: true)
            }
        }
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
    
    // 타이머 시작
    func startTimer(autoStart: Bool) {
        dispatchTimer?.cancel()
        dispatchTimer = nil

        if autoStart {
            // 앱 재실행 후 타이머 자동 재시작
            // AppStorage에서 타이머 종료 시간 불러오기
            self.endTime = appStateManager.timerEndTime
        } else {
            // 앱 차단
            AppLimiter.shared.startBlockingAllApps(for: max(TimeInterval(model.initialTime / 1000), 900))
            // 로컬 알림 등록
            scheduleNotification(identifier: "timerEndNotification")
            
            // AppStorage에 타이머 종료 시간, 앱 상태 저장
            appStateManager.timerEndTime = endTime
            appStateManager.lastAppState = .timerStarted
            
            self.endTime = Date().addingTimeInterval(Double(model.initialTime) / 1000)
            
            
            // 서버로 로그 전송
            clickLog()
        }

        timeRemaining = max(Int(self.endTime.timeIntervalSince(Date()) * 1000), 0)
        var seconds = (timeRemaining % 60000) / 1000
        timerActive = true

        firstTouchfeedbackGenerator.impactOccurred()

        let timer = DispatchSource.makeTimerSource(queue: .main)
        timer.schedule(deadline: .now(), repeating: .milliseconds(10))

        timer.setEventHandler { [weak self] in
            guard let self = self else { return }
            self.timeRemaining = max(Int(self.endTime.timeIntervalSince(Date()) * 1000), 0)
            let newSeconds = (self.timeRemaining % 60000) / 1000

            if newSeconds != seconds {
                seconds = newSeconds
                if (!isHapticsDisabled){
                    Task{
                        self.feedbackGenerator.impactOccurred()
                    }
                }
            }

            if self.timeRemaining <= 0 {
                self.stopTimer()
                self.showNextView = true
            }
        }

        dispatchTimer = timer
        timer.resume()
    }
    
    func stopTimer() {
        dispatchTimer?.cancel()
        dispatchTimer = nil
        timerActive = false
    }
    
    // 🔹 2. 2분 뒤 알림 예약
    func scheduleNotification(identifier: String) {
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString("timer_end_noti_title", comment: "")
        content.body = NSLocalizedString("timer_end_noti_body", comment: "")
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

    
    func tryGetPermission() {
        Task{
            await getPermission.requestFamilyControlsPermission()
            await checkAndRequestNotificationPermission()
        }
    }
    
    func checkAndRequestNotificationPermission() async {
        let center = UNUserNotificationCenter.current()
        let settings = await center.notificationSettings()

        switch settings.authorizationStatus {
        case .notDetermined:
            await getPermission.requestNotificationPermission()
        case .denied:
            // 이전에 거절한 경우 설정 앱으로 유도
            print("⚠️ 알림 권한이 거부되어 설정 앱으로 유도 필요")
            if let url = URL(string: UIApplication.openSettingsURLString),
               UIApplication.shared.canOpenURL(url) {
                await UIApplication.shared.open(url)
            }
        case .authorized, .provisional, .ephemeral:
            print("✅ 이미 알림 권한 있음")
        @unknown default:
            break
        }
    }
    
    func checkPermissionsAndStartTimer(autoStart: Bool) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            
            // Check familyControls permission.
            guard AppLimiter.shared.isAuthorized else {
                print("Family controls permission not granted")
                DispatchQueue.main.async {
                    self.showPermissionErrorMsgModal = true
                }
                return
            }
            
            // Check Notification permissions
            guard settings.authorizationStatus == .authorized else {
                print("Notification permission not granted")
                DispatchQueue.main.async {
                    self.showPermissionErrorMsgModal = true
                }
                return
            }
            
            // If both permissions are granted, start the timer on the main thread.
            DispatchQueue.main.async {
                self.startTimer(autoStart: autoStart)
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
