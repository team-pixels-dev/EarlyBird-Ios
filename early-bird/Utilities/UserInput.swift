//
//  UserInput.swift
//  early-bird
//
//  Created by JAYOU KOO on 4/13/25.
//

// 사용자 입력 저장 및 관리

import SwiftUI

class UserInputManager: ObservableObject {
    // 싱글톤으로 정의
    static let shared = UserInputManager()
    
    // 미룸 이유 저장
    @AppStorage("procrastinationText") private var procrastinationTextRaw: String = ""
    
    // 스트레스 받기 싫은 이유 저장
    @AppStorage("stressText") private var stressTextRaw: String = ""
    
    // 다짐 저장
    @AppStorage("resolutionText") private var resolutionTextRaw: String = ""
    
    var procrastinationText: String {
        get { self.procrastinationTextRaw }
        set { self.procrastinationTextRaw = newValue }
    }
    
    var stressText: String {
        get { self.stressTextRaw }
        set {self.stressTextRaw = newValue }
    }
    
    var resolutionText: String {
        get { self.resolutionTextRaw }
        set {self.resolutionTextRaw = newValue }
    }
    
}
