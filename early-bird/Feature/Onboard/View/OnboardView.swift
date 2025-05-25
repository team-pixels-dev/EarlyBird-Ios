//
//  Onboard.swift
//  early-bird
//
//  Created by JAYOU KOO on 4/17/25.
//
import SwiftUI

struct OnboardView: View {
    @State private var isAgree: Bool = false
    
    private let coordinator: OnboardingCoordinator
    
    init(coordinator: OnboardingCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        ZStack{
            SplashView()
            VStack {
                Spacer()
                TermText(isChecked: $isAgree)
                    .padding(.bottom, 24)
                RoundedButton(buttonText: "시작", buttonAction: {coordinator.goToNext()}, type: .middle, disabled: !isAgree)
            }
        }
    }
}
