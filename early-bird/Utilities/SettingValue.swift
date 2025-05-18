//
//  SettingValue.swift
//  early-bird
//
//  Created by JAYOU KOO on 4/13/25.
//

// 설정 값 저장

import SwiftUI

class SettingValue: ObservableObject {
    // 싱글톤으로 정의
    static let shared = SettingValue()
    
    // 알림 수신 활성화
    @AppStorage("notiActive") private var notiActiveRaw: Bool = true
    
    // 정기 알림 수신 활성화
    @AppStorage("specificTimeNotiActive") private var specificTimeNotiActiveRaw: Bool = true
    
    // 정기 알림 수신 활성화
    @AppStorage("isDataCollectionEnabled") private var isDataCollectionEnabledRaw: Bool = true
    
    var notiActive: Bool {
        get { self.notiActiveRaw }
        set {
            self.notiActiveRaw = newValue
            ScheduleNotification.shared.updateNotificationStatus()
        }
    }
    
    var specificTimeNotiActive: Bool {
        get { self.specificTimeNotiActiveRaw }
        set {
            self.specificTimeNotiActiveRaw = newValue
            ScheduleNotification.shared.updateNotificationStatus()
        }
    }
    
    var isDataCollectionEnabled: Bool {
        get { self.isDataCollectionEnabledRaw }
        set {
            self.isDataCollectionEnabledRaw = newValue
        }
    }
    
}
