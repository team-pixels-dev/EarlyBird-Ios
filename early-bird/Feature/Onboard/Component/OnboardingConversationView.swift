//
//  OnboardingConversationView.swift
//  early-bird
//
//  Created by JAYOU KOO on 4/14/25.
//


import SwiftUI

struct OnboardingConversationView: View {
    let messages: [(LocalizedStringKey, Color?, Double)]
    let visibleCount: Int

    var body: some View {
        VStack(alignment: .leading) {
            Image("onboardMascot")
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 90)
                .padding(.bottom, 20.0)

            ForEach(0..<visibleCount, id: \.self) { index in
                let (text, color, _) = messages[index]
                ConversationLabel(text: text, color: color ?? Theme.mainTextColor)
                    .transition(.opacity)
            }

            Spacer()
        }
        .frame(width: 336, height: 300, alignment: .leading)
        .padding(.top, 70.0)
    }
}
