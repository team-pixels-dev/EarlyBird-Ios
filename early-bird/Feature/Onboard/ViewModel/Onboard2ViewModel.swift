//
//  Onboard2ViewModel.swift
//  early-bird
//
//  Created by JAYOU KOO on 4/14/25.
//


import Foundation
import SwiftUI

class Onboard2ViewModel: ObservableObject {
    @Published var inputText: String = UserInputManager.shared.stressText
    @Published var visibleCount = 0
    @Published var showTextInput = false

    private let coordinator: OnboardingCoordinator

    init(coordinator: OnboardingCoordinator) {
        self.coordinator = coordinator
    }

    let conversation: [(LocalizedStringKey, Color?, Double)] = [
        ("나 요즘 자꾸 미루는 스스로한테 지쳐…", nil, 0.0),
        ("너도 이제 그만 스트레스 받고 싶지 않아?", nil, 1.5),
        ("(진짜 이유, 나한테만 살짝 말해줘!)", Theme.mainTextColor2, 2.0)
    ]

    func startAnimationSequence() {
        visibleCount = 0
        showTextInput = false
        
        var time: Double = 0.0
        for (index, (_, _, delay)) in conversation.enumerated() {
            time += delay
            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                withAnimation(.easeOut(duration: 0.5)) {
                    self.visibleCount = index + 1
                }
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + time + 1.5) {
            withAnimation(.easeOut(duration: 0.5)) {
                self.showTextInput = true
            }
        }
    }

    func submit() {
        UserInputManager.shared.stressText = inputText
        
        let StressAvoidReasonData = StressAvoidReason(
            comment: inputText,
            clientId: ClientIDManager.getClientID(),
            createdAt: formatDate(Date())
        )
        
        sendPostRequest(to: "/api/v1/onboarding/stress-avoid-reason", with: StressAvoidReasonData){_ in}
        coordinator.goToNext()
    }
}
