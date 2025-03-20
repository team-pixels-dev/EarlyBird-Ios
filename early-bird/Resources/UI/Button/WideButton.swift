//
//  WideButton.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/11/25.
//

import SwiftUI

struct WideButton: View {
    let buttonText: String
    let buttonAction : () -> Void
    let disabled: Bool
    var body: some View {
        Button(action: buttonAction){
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(Theme.primaryColor) // fill 대신 foregroundColor 사용
                    .frame(width: 350, height: 64)
                    .shadow(color: Theme.secondaryColor.opacity(0.5), radius: 2, x: 1, y: 8)
                    Text(buttonText)
                        .font(.system(size: 30))
                        .foregroundColor(Theme.brightTextColor)
            }
        }.disabled(disabled)
    }
}

#Preview {
    WideButton(buttonText: "test", buttonAction: {}, disabled: false)
}
