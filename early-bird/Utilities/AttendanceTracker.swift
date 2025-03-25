//
//  Attendance.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/18/25.
//

// 출석 확인 로직

import SwiftUI

struct AttendanceTracker {
    private let userDefaults = UserDefaults.standard
    private let attendanceKey = "attendanceDates"
    
    /// 저장된 출석 일수를 반환 (중복 없이 저장됨)
    var totalAttendance: Int {
        let dates = userDefaults.array(forKey: attendanceKey) as? [String] ?? []
        return dates.count
    }
    
    /// 오늘 출석 여부 확인 후 업데이트
    mutating func markAttendance() -> Int? {
        let today = formattedDate(Date()) // 오늘 날짜 (yyyy-MM-dd)
        var savedDates = userDefaults.array(forKey: attendanceKey) as? [String] ?? []
        
        if !savedDates.contains(today) {
            savedDates.append(today) // 새로운 날짜 저장
            userDefaults.set(savedDates, forKey: attendanceKey)
            print("✅ 출석 완료! 총 출석 횟수: \(savedDates.count)")
        } else {
            print("⚠️ 이미 오늘 출석했음.")
            return -1
        }
        
        // 출석 횟수 return
        return savedDates.count
    }
    
    /// 날짜를 "yyyy-MM-dd" 형식으로 변환
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
