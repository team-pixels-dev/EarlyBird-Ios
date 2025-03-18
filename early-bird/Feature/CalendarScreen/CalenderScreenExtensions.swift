//
//  CalenderScreenExtensions.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/4/25.
//
import SwiftUI

// Date 확장: 주의 시작과 끝 날짜 계산
extension Calendar {
    func startOfWeek(for date: Date) -> Date {
        let components = dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        return self.date(from: components)!
    }

    func endOfWeek(for date: Date) -> Date {
        let start = startOfWeek(for: date)
        return self.date(byAdding: .day, value: 6, to: start)!
    }
}

// Date 확장: 날짜 포맷팅
extension Date {
    func formatted() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}
