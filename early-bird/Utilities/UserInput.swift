//
//  AppState.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/19/25.
//

// 앱 상태 저장 매니저

import SwiftUI

class UserInputManager: ObservableObject {
    // 앱의 마지막 상태 저장
    @AppStorage("lastAppState") private var lastAppStateRaw: String = AppState.home.rawValue
    
    // 타이머 종료 시점 저장
    @AppStorage("timerEndTime") private var timerEndTimeRaw: Double = 0  // Date를 Double로 저장
    
    var lastAppState: AppState {
        get { AppState(rawValue: lastAppStateRaw) ?? .home }
        set {  DispatchQueue.main.async {self.lastAppStateRaw = newValue.rawValue} }
    }

    var timerEndTime: Date {
        // Date를 double로 저장
        get { Date(timeIntervalSince1970: timerEndTimeRaw) }
        
        // double를 Date로 저장
        set {  DispatchQueue.main.async {self.timerEndTimeRaw = newValue.timeIntervalSince1970} }
    }
}
