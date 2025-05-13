import Foundation
import SwiftUI

class SettingViewModel: ObservableObject {
    @Published var sections: [SettingSection]
    @Published var isNotificationEnabled = false
    @Published var isTimeNotificationEnabled = false
    @Published var isDataCollectionEnabled = false
    @Published var gotoPrivacyPolicy = false
    
    init() {
        self.sections = SettingModel.shared.sections
        self.isNotificationEnabled = UserDefaults.standard.bool(forKey: "isNotificationEnabled")
        self.isTimeNotificationEnabled = UserDefaults.standard.bool(forKey: "isTimeNotificationEnabled")
        self.isDataCollectionEnabled = UserDefaults.standard.bool(forKey: "isDataCollectionEnabled")
    }
    
    func toggleNotification() {
        isNotificationEnabled.toggle()
        UserDefaults.standard.set(isNotificationEnabled, forKey: "isNotificationEnabled")
        // TODO: 실제 알림 권한 요청 및 처리 로직 구현
    }
    
    func toggleTimeNotification() {
        isTimeNotificationEnabled.toggle()
        UserDefaults.standard.set(isTimeNotificationEnabled, forKey: "isTimeNotificationEnabled")
        // TODO: 실제 시간 알림 설정 로직 구현
    }
    
    func toggleDataCollection() {
        isDataCollectionEnabled.toggle()
        UserDefaults.standard.set(isDataCollectionEnabled, forKey: "isDataCollectionEnabled")
        // TODO: 실제 데이터 수집 설정 로직 구현
    }
    
    func openFeedback() {
        print("open feedback")
        // TODO: 피드백 화면으로 이동하는 로직 구현
    }
    
    func openTerms() {
        print("open terms")
        // TODO: 이용약관 화면으로 이동하는 로직 구현
        if let url = URL(string: "https://cubic-tax-461.notion.site/1f00c4f14a908025b95bf2f0308a8479?pvs=4") {
            UIApplication.shared.open(url)
        }
    }
    
    func openPrivacy() {
        print("open privacy")
        gotoPrivacyPolicy = true
    }
    
    func openPrivacyPolicy() {
        print("open privacy policy")
        if let url = URL(string: "https://cubic-tax-461.notion.site/1f00c4f14a9080bdb937e3a95a395201?pvs=4") {
            UIApplication.shared.open(url)
        }
    }
} 
