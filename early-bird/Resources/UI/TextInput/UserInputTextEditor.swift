//
//  UserInputTextEditor.swift
//  early-bird
//
//  Created by JAYOU KOO on 4/14/25.
//

import SwiftUI

struct CustomBigTextField: View {
    @Binding var text: String
    var placeholder: LocalizedStringKey
    var maxLength: Int = 50

    var body: some View {
        ZStack {
            HStack(alignment: .top){
                TextField("", text: $text)
                    .font(.custom("Pretendard-Regular", size: 18))
                    .padding(.leading, 25)
                    .padding(.top, 23)
                    .scrollContentBackground(.hidden)
                    .foregroundStyle(Theme.mainTextColor)
                    .onChange(of: text) { newValue in
                        if newValue.count > maxLength {
                            text = String(newValue.prefix(maxLength))
                        }
                    }
                Spacer()
            }.frame(width: 337, height: 214, alignment: .top)
            
            HStack(alignment: .top){
                FontText(text: placeholder, size: 18)
                    .padding([.top, .leading], 25)
                    .foregroundStyle(text.isEmpty ? .gray : .clear)
                Spacer()
            }.frame(width: 337, height: 214, alignment: .top)
        }
        .frame(width: 337, height: 214)
        .background(Theme.textLabelBgColor)
        .cornerRadius(15)
    }
}
