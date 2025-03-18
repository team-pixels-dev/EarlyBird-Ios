//
//  TimerModel.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/9/25.
//

import Foundation

struct TimerModel {
    let initialTime: Int = 1 * 10 * 1000 // 15분 (밀리초 단위)
}

struct ClickLogJson : Codable{
    let clientId : String
    let clickType : String
    let clickTime : String
}
