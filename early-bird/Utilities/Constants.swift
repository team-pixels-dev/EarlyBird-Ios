//
//  Constants.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/17/25.
//

import Foundation

struct Constants {
    static let BASE_URL = "https://earlybirdteam.com"
}

struct ClientIDManager {
    private static let clientIDKey = "clientID"
    
    // 저장된 client_ID 불러오기 (없으면 새로 생성)
    static func getClientID() -> String {
        if let savedClientID = UserDefaults.standard.string(forKey: clientIDKey) {
            return savedClientID
        } else {
            let newClientID = UUID().uuidString // UUID 생성
            UserDefaults.standard.set(newClientID, forKey: clientIDKey)
            return newClientID
        }
    }
}
