//
//  FeedbackItemView.swift
//  test
//
//  Created by JAYOU KOO on 5/12/25.
//

import SwiftUI

struct FeedbackItemView: View {
    @ObservedObject var viewModel: SettingViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            FontText(text: "피드백", weight: .regular, size: 14, alignment: .leading)
                .foregroundStyle(Theme.descriptionTextColor)
                .padding(.horizontal, 16)
                .padding(.top, 24)
                .padding(.bottom, 8)
            
            HStack(spacing: 0) {
                VStack(spacing: 20) {
                    Spacer()
                    VStack(spacing: 4){
                        FontText(text: "단순한 기능 제안도 좋아요!", weight: .bold, size: 24, alignment: .center)
                            .foregroundStyle(Theme.mainTextColor2)
                        FontText(text: "여러분이 겪는 진짜 문제를 들려주면 더 좋아요!🐥", weight: .medium, size: 14, alignment: .center)
                            .foregroundStyle(Theme.mainTextColor2)
                    }
                    FontText(text: "얼리버드는 여러분과 함께 완성돼요", weight: .regular, size: 14)
                        .foregroundStyle(Theme.descriptionTextColor)
                    NormalButton(buttonText: "제안하기", buttonAction: {viewModel.showTextFeedbackModal = true}, type: .middle, disabled: false)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            }
            .background(Theme.backgroundColor)
            .cornerRadius(8)
            .padding(.horizontal, 16)
        }
    }
}
