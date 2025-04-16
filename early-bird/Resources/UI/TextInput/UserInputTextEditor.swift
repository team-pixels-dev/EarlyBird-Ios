//
//  UserInputTextEditor.swift
//  early-bird
//
//  Created by JAYOU KOO on 4/14/25.
//

import SwiftUI

struct UserInputTextEditor: View {
    @Binding var text: String
    var placeholder: LocalizedStringKey

    var body: some View {
        VStack {
            TextEditor(text: $text)
                .font(.custom("Pretendard-Regular", size: 18))
                .padding(.leading, 20)
                .padding(.top, 16)
                .scrollContentBackground(.hidden)
                .foregroundColor(Theme.mainTextColor)
                .overlay(alignment: .topLeading) {
                    FontText(text: placeholder, size: 18)
                        .padding([.top, .leading], 25)
                        .foregroundStyle(text.isEmpty ? .gray : .clear)
                }
        }
        .background(Theme.textLabelBgColor)
        .cornerRadius(15)
        .frame(width: 337, height: 214)
    }
}
