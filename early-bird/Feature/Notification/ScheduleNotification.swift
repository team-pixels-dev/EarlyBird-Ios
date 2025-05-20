//
//  ScheduleNotification.swift
//  early-bird
//
//  Created by JAYOU KOO on 5/11/25.
//

import UserNotifications
import SwiftUI

class ScheduleNotification {
    static let shared = ScheduleNotification()
    
    private init() {}

    /// 알림 설정 상태를 업데이트합니다.
    func updateNotificationStatus() {
        let settingValue = SettingValue.shared
        
        if !settingValue.specificTimeNotiActive {
            // weekdayNotification으로 시작하는 알림만 제거
            let center = UNUserNotificationCenter.current()
            center.getPendingNotificationRequests { requests in
                let weekdayIdentifiers = requests
                    .filter { $0.identifier.hasPrefix("weekdayNotification") }
                    .map { $0.identifier }
                center.removePendingNotificationRequests(withIdentifiers: weekdayIdentifiers)
            }
        } else {
            // 특정 시간 알림 활성화시 알림 예약
            scheduleMorningNoti()
            scheduleNightNoti()
        }
    }

    /// 특정 요일들과 시간에 반복 알림을 예약합니다.
    /// - Parameters:
    ///   - weekdays: 알림을 보낼 요일 배열 (2 = 월요일 ~ 6 = 금요일)
    ///   - hour: 알림 시간 (0~23)
    ///   - minute: 알림 분 (0~59)
    func scheduleNotifications(for weekdays: [Int], hour: Int, minute: Int, noti_title: String, noti_body: String, type: String) {
        let center = UNUserNotificationCenter.current()

        for weekday in weekdays {
            let identifier = "weekdayNotification_\(weekday)_\(type)"
            
            center.removePendingNotificationRequests(withIdentifiers: [identifier])
            
            var dateComponents = DateComponents()
            dateComponents.weekday = weekday
            dateComponents.hour = hour
            dateComponents.minute = minute

            let content = UNMutableNotificationContent()
            content.title = NSLocalizedString(noti_title, comment: "")
            content.body = NSLocalizedString(noti_body, comment: "")
            content.sound = .default

            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

            center.add(request) { error in
                if let error = error {
                    print("알림 스케줄링 중 오류 발생: \(error.localizedDescription)")
                } else {
                    print("📅 요일 \(weekday) - \(hour):\(String(format: "%02d", minute)) 알림 설정됨")
                }
            }
        }
    }

    func removeAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func scheduleMorningNoti(){
        if SettingValue.shared.specificTimeNotiActive {
            // 09시 알림 예약
            scheduleNotifications(
                for: [1,2,3,4,5,6,7],
                hour: 09,
                minute: 00,
                noti_title: "morning_noti_title",
                noti_body: "morning_noti_body",
                type: "morning"
            )
            print("📅 아침 알림 예약 완료")
        }
    }
    
    func scheduleNightNoti(){
        if SettingValue.shared.specificTimeNotiActive {
            // 23시 알림 예약
            scheduleNotifications(
                for: [1,2,3,4,5,6,7],
                hour: 23,
                minute: 0,
                noti_title: "evening_noti_title",
                noti_body: "evening_noti_body",
                type: "evening"
            )
            print("📅 밤 알림 예약 완료")
        }
    }
}
