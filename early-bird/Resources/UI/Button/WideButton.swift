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
                    .fill(Theme.primaryColor)
                    .frame(width: 350, height: 64)
                    .shadow(color: Color(Theme.secondaryColor), radius: 2, x: 1, y: 8)
                    Text(buttonText)
                        .font(.system(size: 30))
                        .foregroundColor(Theme.brightTextColor)
            }
        }.disabled(disabled)
    }
}
