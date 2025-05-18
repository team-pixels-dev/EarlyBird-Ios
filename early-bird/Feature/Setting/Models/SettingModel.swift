import Foundation
import SwiftUI

struct SettingSection {
    let title: String
    let items: [SettingItem]
}

struct SettingItem: Equatable {
    let title: String
    let description: String
    let type: SettingItemType
    
    static func == (lhs: SettingItem, rhs: SettingItem) -> Bool {
        return lhs.title == rhs.title &&
               lhs.description == rhs.description &&
               lhs.type == rhs.type
    }
}

enum SettingItemType: Equatable {
    case notification
    case timeNotification
    case feedback
    case terms
    case privacy
    case privacyPolicy
    case dataCollection
}

class SettingModel {
    static let shared = SettingModel()
    
    let feedback: SettingSection =  SettingSection(title: "피드백", items: [
        SettingItem(title: "얼리버드는 여러분과 함께 완성돼요", description: "단순한 기능 제안도 좋아요!\n여러분이 겪는 진짜 문제를 들려주면 더 좋아요!🐥", type: .feedback)
    ])
    
    let sections: [SettingSection] = [
        SettingSection(title: "알림 설정", items: [
//            SettingItem(title: "알림 권한", description: "앱 알림을 허용합니다.", type: .notification),
            SettingItem(title: "특정 시간 알림", description: "하루의 시작과 끝, 얼리버드와 함께 해요.", type: .timeNotification)
        ]),
        SettingSection(title: "약관 및 정책", items: [
            SettingItem(title: "서비스 이용약관", description: "", type: .terms),
            SettingItem(title: "개인정보처리방침 설정", description: "", type: .privacy)
        ])
    ]
    
    let privacySections: [SettingSection] = [
        SettingSection(title: "약관 및 정책", items: [
            SettingItem(title: "개인정보 처리 방침", description: "", type: .privacyPolicy)
        ]),
        SettingSection(title: "알림 설정", items: [
            SettingItem(title: "앱 사용 데이터 수집", description: "앱 개선을 위해 익명 데이터를 수집해요.", type: .dataCollection)
        ])
    ]
} 
