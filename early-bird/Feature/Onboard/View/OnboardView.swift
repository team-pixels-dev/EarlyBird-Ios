//
//  Onboard.swift
//  early-bird
//
//  Created by JAYOU KOO on 4/17/25.
//


//
//  Onboard1.swift
//  early-bird
//
//  Created by JAYOU KOO on 4/9/25.
//
import SwiftUI

struct OnboardView: View {
    var body: some View {
        VStack {
            FontText(text: "catchphrase_1", weight: .medium, size: 26, alignment: .center)
                .foregroundColor(Theme.mainTextColor1)
            FontText(text: "얼리버드", size: 56, alignment: .center, font: .oneMobilePop)
                .foregroundColor(Theme.primaryColor)
        }
        .applyBackgroundWhite()
        .onAppear {
            
        }
    }
}

#Preview {
    OnboardView()
}
