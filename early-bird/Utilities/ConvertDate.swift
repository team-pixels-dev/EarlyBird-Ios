//
//  ConvertDate.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/18/25.
//

// 날짜 형식 변환

import Foundation

func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    formatter.timeZone = TimeZone.current // 현재 타임존 사용
    return formatter.string(from: date)
}

func formatDateText(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone.current
    
    if isLanguageKorean() {
        formatter.dateFormat = "M월 d일 EEEE" // 예: 5월 15일 목요일
    } else {
        formatter.dateFormat = "EEEE, MMMM d" // 예: Thursday, May 15
    }
    
    return formatter.string(from: date)
}

func isLanguageKorean() -> Bool {
    Locale.preferredLanguages.first?.hasPrefix("ko") == true
}
