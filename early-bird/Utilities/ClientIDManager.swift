//
//  ClientIDManager.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/25/25.
//

import Foundation
import SwiftUI

struct ClientIDManager {
    private static let clientIDKey = "clientID"
    @AppStorage("isTeamMember") static var isTeamMember: Bool = false
    
    // 저장된 client_ID 불러오기 (없으면 새로 생성)
    static func getClientID() -> String {
        if (isTeamMember) {
            // 팀 멤버라면 clientId 고정
            return "earlybird"
        }
        if let savedClientID = UserDefaults.standard.string(forKey: clientIDKey) {
            return savedClientID
        } else {
            let newClientID = UUID().uuidString // UUID 생성
            UserDefaults.standard.set(newClientID, forKey: clientIDKey)
            return newClientID
        }
    }
}
