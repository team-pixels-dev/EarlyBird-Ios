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

enum FontList: Int {
    case pretendard = 0
    case oneMobilePop = 1
}

struct FontText: View {
    var text: LocalizedStringKey
    var weight: FontWeightType = .regular
    var size: CGFloat = 16
    var alignment: TextAlignment = .leading
    var font: FontList = .pretendard
    
    var body: some View {
        switch font {
        case .pretendard:
        Text(text)
            .font(.custom("Pretendard-\(weight.rawValue)", size: size))
            .multilineTextAlignment(alignment)
            .padding(0)
        case .oneMobilePop:
            Text(text)
                .font(.custom("ONE Mobile POP", size: size))
                .multilineTextAlignment(alignment)
                .padding(0)
        }
        
    }
}
