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
}
