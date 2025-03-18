//
//  ConvertDate.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/18/25.
//
import Foundation

func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    formatter.locale = Locale(identifier: "ko_KR") // 로케일 설정 (한국 기준)
    formatter.timeZone = TimeZone.current // 현재 타임존 사용
    return formatter.string(from: date)
}
