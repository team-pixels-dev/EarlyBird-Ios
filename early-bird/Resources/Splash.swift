//
//  Splash.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/11/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack {
            Spacer()
            FontText(text: "catchphrase_1", weight: .medium, size: 26, alignment: .center)
                .foregroundStyle(Theme.mainTextColor1)
            FontText(text: "얼리버드", size: 56, alignment: .center, font: .oneMobilePop)
                .foregroundStyle(Theme.primaryColor)
            Spacer()
        }
        .applyBackgroundWhite()
        .onAppear {
            
        }
    }
}

#Preview {
    SplashView()
}
