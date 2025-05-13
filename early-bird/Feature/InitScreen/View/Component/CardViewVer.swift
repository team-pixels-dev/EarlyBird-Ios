//
//  CardViewVer.swift
//  early-bird
//
//  Created by JAYOU KOO on 5/12/25.
//


import SwiftUI

struct CardViewVer: View {
    let buttonText: LocalizedStringKey
    let description: LocalizedStringKey
    let buttonAction: () -> Void
    let color: LocalizedStringKey
    
    var body: some View {
        VStack(alignment: .center, spacing: 45) {
            Text(description)
                .font(.custom("Pretendard-SemiBold", size: 16))
                .foregroundColor(color == "tint" ? Theme.brightTextColor : Theme.mainTextColor2)
            Image("LockIcon")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 67)
            HStack {
                Text(buttonText)
                    .font(.custom("Pretendard-Bold", size: 20))
                    .foregroundColor(Theme.mainTextColor2)
                Image("lineArrowIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            .frame(width: 290, height: 40)
            .background(color == "tint" ? Theme.backgroundColor : Theme.primaryColor)
            .cornerRadius(10)
        }
        .frame(width: 366, height: 270)
        .background(color == "tint" ? Theme.primaryColor : Theme.backgroundColor)
        .cornerRadius(10)
    }
}
