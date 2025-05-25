//
//  MainBottomActionView.swift
//  early-bird
//
//  Created by JAYOU KOO on 5/23/25.
//
import SwiftUI

struct MainBottomActionView: View {
    let onStartTapped: () -> Void
    
    var body: some View {
        VStack {
            FontText(text: "얼리버드와 함께 해요!", weight: .bold, size: 22, alignment: .center)
                .foregroundStyle(Theme.mainTextColor2)
                .padding(.top, 30)
                .padding(.bottom, 20)
            
            RectangleButton(buttonText: "원하는 시간에 시작하기", buttonTextColor: Theme.brightTextColor, buttonAction: {}, disabled: false, backgroundColor: Theme.primaryColor, showdowColor: Color.black.opacity(0.25))
            
            RectangleButton(buttonText: "지금 당장 시작하기", buttonTextColor: Theme.primaryColor, buttonAction: onStartTapped, disabled: false, backgroundColor: Theme.brightTextColor, showdowColor: Color.black.opacity(0.25))
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 370)
        .background(
            Theme.backgroundColor
                .clipShape(RoundedCorner(radius: 30, corners: [.topLeft, .topRight]))
        )
        .ignoresSafeArea()
    }
}
