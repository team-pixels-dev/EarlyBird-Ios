//
//  Onboard1ViewModel.swift
//  early-bird
//
//  Created by JAYOU KOO on 4/14/25.
//
import SwiftUI

class Onboard1ViewModel: ObservableObject {
    @Published var inputText: String = UserInputManager.shared.procrastinationText
    @Published var visibleCount = 0
    @Published var showTextInput = false
    
    private let coordinator: OnboardingCoordinator

    init(coordinator: OnboardingCoordinator) {
        self.coordinator = coordinator
    }

    let conversation: [(LocalizedStringKey, Color?, Double)] = [
        ("반가워! 나는 얼리버드야!", nil, 0.0),
        ("우리가 잘 지내기 위해,\n너에 대해 조금만 알려줄 수 있을까?", nil, 1.5),
        ("(이번만이야. 1분도 안 걸려!)", Theme.mainTextColor2, 2.5)
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
        UserInputManager.shared.procrastinationText = inputText
        
        let DelayingReasonData = DelayingReason(
            comment: inputText,
            clientId: ClientIDManager.getClientID(),
            createdAt: formatDate(Date())
        )
        
        sendPostRequest(to: "/api/v1/onboarding/delaying-reason", with: DelayingReasonData){_ in}
        coordinator.goToNext()
    }
}
