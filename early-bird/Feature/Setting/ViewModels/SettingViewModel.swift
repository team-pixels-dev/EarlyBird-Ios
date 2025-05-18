import Foundation
import SwiftUI
import FirebaseAnalytics

/// 설정 화면의 비즈니스 로직을 담당하는 ViewModel
@MainActor
class SettingViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var sections: [SettingSection]
    @Published var privacySections: [SettingSection]
    @Published var isNotificationEnabled = true
    @Published var isTimeNotificationEnabled = true
    @Published var isDataCollectionEnabled = true
    @Published var gotoPrivacyPolicy = false
    
    // MARK: - Private Properties
    private var settingValue = SettingValue.shared
    private var getPermission = GetPermission()
    
    // MARK: - Initialization
    init() {
        self.sections = SettingModel.shared.sections
        self.privacySections = SettingModel.shared.privacySections
        self.isDataCollectionEnabled = settingValue.isDataCollectionEnabled
        
        Task {
            await checkNotificationPermission()
        }
        
        
    }
    
    // MARK: - Lifecycle Methods
    func onForeground() {
        guard isNotificationEnabled else { return }
        
        Task {
            await checkNotificationPermission()
        }
    }
    
    // MARK: - Notification Methods
    private func checkNotificationPermission() async {
        switch await getPermission.getNofiPermissonState() {
        case .authorized, .provisional, .ephemeral:
            break
        case .notDetermined, .denied:
            settingValue.notiActive = false
            settingValue.specificTimeNotiActive = false
        @unknown default:
            break
        }
        
        self.isNotificationEnabled = settingValue.notiActive
        self.isTimeNotificationEnabled = settingValue.specificTimeNotiActive
    }
    
    func toggleNotification() {
        Task {
            await getPermission.checkAndRequestNotificationPermission()
        }
        
        isNotificationEnabled.toggle()
        settingValue.notiActive = isNotificationEnabled
        
        // 알림이 비활성화되면 시간 알림도 비활성화
        if !isNotificationEnabled {
            isTimeNotificationEnabled = false
        } else if !isTimeNotificationEnabled {
            isTimeNotificationEnabled = true
        }
        
        settingValue.specificTimeNotiActive = isTimeNotificationEnabled
    }
    
    func toggleTimeNotification() {
        isTimeNotificationEnabled.toggle()
        settingValue.specificTimeNotiActive = isTimeNotificationEnabled
        
        // 시간 알림이 활성화되면 기본 알림도 활성화
        if !isNotificationEnabled {
            toggleNotification()
        }
    }
    
    // MARK: - Data Collection Methods
    func toggleDataCollection() {
        isDataCollectionEnabled.toggle()
        
        settingValue.isDataCollectionEnabled = isDataCollectionEnabled
        Analytics.setAnalyticsCollectionEnabled(isDataCollectionEnabled)
    }
    
    // MARK: - Navigation Methods
    func openFeedback() {
        print("open feedback")
        // TODO: 피드백 화면으로 이동하는 로직 구현
    }
    
    func openTerms() {
        print("open terms")
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
