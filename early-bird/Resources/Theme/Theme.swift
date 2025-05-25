//
//  Apperence.swift
//  early-bird
//
//  Created by JAYOU KOO on 2/24/25.
//

import SwiftUI

struct Theme {
    // 색상 정의
    static let appBackgroundColor = theme(light: "#F9F9F9", dark: "#F9F9F9")
    static let primaryColor = theme(light: "#00A2CB", dark: "#00A2CB")
    static let secondaryColor = theme(light: "#36CAF0", dark: "#36CAF0")
    static let backgroundColor = Color.white
    static let brightTextColor = theme(light: "#FFFFFF", dark: "#FFFFFF")
    static let wrongColor = theme(light: "#FF6666", dark: "#FF6666")
    
    // 검은 계열 정리 (명도 내림차순)
    static let mainTextColor = theme(light: "#000000", dark: "#000000")          // 명도: 0.00
    static let mainTextColor1 = theme(light: "#343434", dark: "#343434")        // 명도: 0.18
    static let mainTextColor2 = theme(light: "#4C4C4C", dark: "#4C4C4C")        // 명도: 0.30
    static let grayTextColor = theme(light: "#575757", dark: "#575757")        // 명도: 0.35
    static let descriptionTextColor = theme(light: "#8D8D8D", dark: "#8D8D8D")  // 명도: 0.55
    static let disabledColor = theme(light: "#A7A7A7", dark: "#A7A7A7")         // 명도: 0.66
    static let grayColor = theme(light: "#B3B3B3", dark: "#B3B3B3")             // 명도: 0.70
    static let textLabelBgColor = theme(light: "#F6F6F6", dark: "#F6F6F6")      // 명도: 0.96
    static let notSelectedColor = theme(light: "#F7F7F7", dark: "#F7F7F7")      // 명도: 0.97
    
    // 폰트 정의
    static let titleFont = Font.system(size: 24, weight: .bold)
    static let bodyFont = Font.system(size: 16, weight: .regular)
    
    // 패딩 정의
    static let defaultPadding: CGFloat = 16
}

struct ThemeEnvironmentKey: EnvironmentKey {
    static let defaultValue: Theme = Theme()
}

extension EnvironmentValues {
    var theme: Theme {
        get { self[ThemeEnvironmentKey.self] }
        set { self[ThemeEnvironmentKey.self] = newValue }
    }
}

func theme(light: String, dark: String) -> Color {
        return Color(light: Color(hex: light), dark: Color(hex: dark))
}
