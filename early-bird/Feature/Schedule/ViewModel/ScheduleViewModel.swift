//
//  ScheduleViewModel.swift
//  early-bird
//
//  Created by JAYOU KOO on 5/29/25.
//


// ScheduleViewModel.swift
import SwiftUI
import Combine

final class ScheduleViewModel: ObservableObject {
    // Presentation
    @Published var imageName: String = "mascotSchedule2"

    // Time picker state
    @Published var selectedHour: Int
    @Published var selectedMinute: Int
    @Published var selectedPeriod: Int    // 0 for AM, 1 for PM
    @Published var selectedRepeatOption: Int = 0  // 0 반복, 1 한 번
    @Published var isVibrationEnabled: Bool? = true
    @Published var titleText: String = ""
    @Published var focusedField: Field? = nil

    private var cancellables = Set<AnyCancellable>()

    init() {
        let now = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: now)
        let minute = calendar.component(.minute, from: now)
        
        self.selectedHour = hour % 12
        self.selectedMinute = minute
        self.selectedPeriod = hour < 12 ? 1 : 0
    }

    func onAppear() {
        // 1초 뒤 제목 textinput에 focuse
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            HapticFeedbackManager.mediumImpact()
            self.focusedField = .mainInput
        }
    }

    func toggleVibration() {
        isVibrationEnabled?.toggle()
    }
}
