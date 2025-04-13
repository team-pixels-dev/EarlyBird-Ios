//
//  Onboard1.swift
//  early-bird
//
//  Created by JAYOU KOO on 4/9/25.
//

import SwiftUI

struct Onboard_1View: View {
    @State private var submittedText: String = ""
    @State private var inputText: String = ""
    
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                Image("onboardMascot")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .padding(.bottom, 20.0)
                ConversationLabel(text: "반가워! 나는 얼리버드야!")
                ConversationLabel(text: "우리가 잘 지내기 위해,\n너에 대해 조금만 알려줄 수 있을까?")
                ConversationLabel(text: "(이번만이야. 1분도 안 걸려!)", color:Theme.mainTextColor2)
            }
            .frame(width: 336.0, height:262.0, alignment: .leading)
            .padding(.top, 90.0)
            
            Spacer()
            
            VStack{
                FontText(text:"내가 미루는 이유", weight: .bold, size:22)
                    .foregroundColor(Theme.mainTextColor)
                
                Spacer()
                
                VStack{
                    TextEditor(text: $inputText)
                        .font(.custom("Pretendard-Regular", size: 18))
                        .frame(maxHeight: .infinity)
                        .scrollContentBackground(.hidden)
                        .foregroundColor(Theme.mainTextColor)
                        .padding(.leading, 20.0)
                        .padding(.top, 16.0)
                        .overlay(alignment: .topLeading) {
                            FontText(text: "여기에 적어주세요!", size:18)
                                .padding([.top, .leading], 25.0)
                                .foregroundStyle(inputText.isEmpty ? .gray : .clear)
                        }
                }
                .background(Theme.textLabelBgColor)
                .cornerRadius(15)
                .frame(width: 337, height: 214)
                
                Spacer()
                
                WideButton(buttonText: "다음", buttonAction: {}, type:.middle, disabled: inputText.isEmpty)
            }
            .frame(height: 329.0)
            .padding(.bottom, 0.0)
        }
        .applyBackgroundWhite()
    }
}

#Preview {
    Onboard_1View()
}
