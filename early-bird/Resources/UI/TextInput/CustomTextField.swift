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
    private let koreanMaxLength = 19
    private let otherMaxLength = 34

    private func isKorean(_ text: String) -> Bool {
        let pattern = "[가-힣]"
        return text.range(of: pattern, options: .regularExpression) != nil
    }

    private func getMaxLength(for text: String) -> Int {
        return isKorean(text) ? koreanMaxLength : otherMaxLength
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
                    let maxLength = getMaxLength(for: newValue)
                    if newValue.count > maxLength {
                        text = String(newValue.prefix(maxLength))
                    }
                }
        }
        .frame(width: width, height: height)
    }
}
