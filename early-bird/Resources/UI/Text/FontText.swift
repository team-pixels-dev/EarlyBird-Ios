//
//  FontText.swift
//  early-bird
//
//  Created by JAYOU KOO on 4/11/25.
//
import SwiftUI

enum FontWeightType: String {
    case regular = "Regular"
    case semiBold = "SemiBold"
    case bold = "Bold"
    case extraBold = "ExtraBold"
    case medium = "Medium"
    case light = "Light"
    case extraLight = "ExtraLight"
    case thin = "Thin"
}

struct FontText: View {
    var text: LocalizedStringKey
    var weight: FontWeightType = .regular
    var size: CGFloat = 16
    var alignment: TextAlignment = .leading
    
    var body: some View {
        Text(text)
            .font(.custom("Pretendard-\(weight.rawValue)", size: size))
            .multilineTextAlignment(alignment)
    }
}
