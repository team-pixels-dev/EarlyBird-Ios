//
//  Onboard2ViewModel.swift
//  early-bird
//
//  Created by JAYOU KOO on 4/14/25.
//


import Foundation
import SwiftUI

class Onboard4ViewModel: ObservableObject {
    @Published var inputText: String = UserInputManager.shared.resolutionText
    @Published var visibleCount = 0
    @Published var showTextInput = false

    private let coordinator: OnboardingCoordinator

    init(coordinator: OnboardingCoordinator) {
        self.coordinator = coordinator
    }

    let conversation: [(LocalizedStringKey, Color?, Double)] = [
        ("좋아! 이제 우리, 조금 가까워졌네 😊", nil, 0.0),
        ("앞으로 어떤 사람이 되고 싶은지 알려줘!", nil, 2.5),
        ("내가 널 도와줄게🤩", nil, 3.5)
//        ("좋아! 이제 우리, 조금 가까워졌네 😊", nil, 0.0),
//        ("앞으로 어떤 사람이 되고 싶은지 알려줘!", nil, 0.0),
//        ("내가 널 도와줄게🤩", nil, 0.0)
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

        DispatchQueue.main.asyncAfter(deadline: .now() + time + 0) {
            withAnimation(.easeOut(duration: 0.5)) {
                self.showTextInput = true
            }
        }
    }

    func submit() {
        UserInputManager.shared.resolutionText = inputText
        
        let UserDescriptionData = UserDescription(
            comment: inputText,
            clientId: ClientIDManager.getClientID(),
            createdAt: formatDate(Date())
        )
        
        sendPostRequest(to: "/api/v1/onboarding/user-description", with: UserDescriptionData){_ in}
        coordinator.goToNext()
    }
}
