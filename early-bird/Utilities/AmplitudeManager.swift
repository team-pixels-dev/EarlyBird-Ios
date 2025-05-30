//
//  AmplitudeManager.swift
//  early-bird
//
//  Created by JAYOU KOO on 5/29/25.
//


import AmplitudeSwift
import Foundation

class AmplitudeManager {
    static var shared = AmplitudeManager()
    private(set) var amplitude: Amplitude
    private init() {
        self.amplitude = Amplitude(configuration: .init(apiKey: Constants.AMPLITUDE_API_KEY))
    }
    
    /// Amplitude 이벤트 추적
    func trackEvent(_ eventName: String, properties: [String: Any]? = nil) {
        amplitude.track(eventType: eventName, eventProperties: properties)
    }
    
    /// Amplitude 초기화 상태 확인
    var isInitialized: Bool {
        return amplitude.configuration.apiKey == Constants.AMPLITUDE_API_KEY
    }
    
    /// 사용자 ID 설정
    func setUserId(_ userId: String) {
        amplitude.setUserId(userId: userId)
    }
    
    /// 온보딩 완료 시 Amplitude 설정
    func configureAfterOnboarding(isTeamMember: Bool) {
        if !isTeamMember {
            setUserId(ClientIDManager.getClientID())
            trackEvent("onboarding_complete", properties: [
                "notification_requested": UserDefaults.standard.bool(forKey: "isNotificationRequested")
            ])
        }
    }
}
