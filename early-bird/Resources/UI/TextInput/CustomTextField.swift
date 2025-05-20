//
//  CustomTextField.swift
//  early-bird
//
//  Created by JAYOU KOO on 4/14/25.
//

import SwiftUI

enum Field {
    case mainInput
}

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: LocalizedStringKey
    var fontSize: CGFloat = 18
    var cornerRadius: CGFloat = 50
    var borderColor: Color = Theme.mainTextColor2
    var placeholderColor: Color = Theme.mainTextColor2
    var width: CGFloat = 249
    var height: CGFloat = 40
    var maxLength: Int {
        if isLanguageKorean() {
            return 13
        } else {
            return 30
        }
    }

    var body: some View {
        ZStack {
            if text.isEmpty {
                // 가운데 정렬 placeholder
                HStack {
                    Spacer()
                    FontText(text: placeholder, weight: .semiBold, size: fontSize)
                        .foregroundColor(placeholderColor)
                    Spacer()
                }
            }

            TextField("", text: $text)
                .textFieldStyle(PlainTextFieldStyle())
                .font(.custom("Pretendard-SemiBold", size: fontSize))
                .foregroundColor(Theme.mainTextColor)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
                .frame(height: height)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(borderColor, lineWidth: 2)
                )
                .onChange(of: text) { newValue in
                    if newValue.count > maxLength {
                        text = String(newValue.prefix(maxLength))
                    }
                }
        }
        .frame(width: width, height: height)
    }
}
