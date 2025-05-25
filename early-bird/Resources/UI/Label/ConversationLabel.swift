//
//  ConversationLabel.swift
//  early-bird
//
//  Created by JAYOU KOO on 4/11/25.
//
import SwiftUI

struct ConversationLabel: View {
    var text: LocalizedStringKey
    var color: Color = Theme.mainTextColor
    
    var body: some View{
        FontText(text: text, weight: .semiBold, size: 18)
            .padding(10.0)
            .background(Theme.textLabelBgColor)
            .foregroundStyle(color)
            .cornerRadius(5.0)
    }
}
