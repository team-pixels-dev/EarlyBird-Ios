//
//  MainTopView.swift
//  early-bird
//
//  Created by JAYOU KOO on 5/12/25.
//


import SwiftUI

struct MainTopView: View {
    private var resolutionText: String = UserInputManager.shared.resolutionText
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("나는")
                .font(.custom("Pretendard-SemiBold", size: 28))
                .foregroundColor(Theme.mainTextColor1)
            Text(resolutionText)
                .font(.custom("Pretendard-SemiBold", size: 28))
                .foregroundColor(Theme.primaryColor)
            if Locale.current.language.languageCode?.identifier == "ko" {
                Text("사람이다.")
                    .font(.custom("Pretendard-SemiBold", size: 28))
                    .foregroundColor(Theme.mainTextColor1)
            }
        }
        .padding(.bottom, 70)
        .padding(.top, 24)
        .padding(.leading, 25)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
