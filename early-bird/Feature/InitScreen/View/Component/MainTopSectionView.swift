//
//  MainTopView.swift
//  early-bird
//
//  Created by JAYOU KOO on 5/12/25.
//
import SwiftUI

struct MainTopSectionView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        ZStack {
            Image("mainPageTop")
                .resizable()
                .scaledToFit()
                .frame(height: 112)
            
            VStack(alignment: .leading) {
                Spacer()
                FontText(text: LocalizedStringKey(formatDateText(Date())), weight: .bold, size: 16, alignment: .center)
                    .foregroundStyle(Theme.mainTextColor2)
                    .padding(.leading, 70)
                
                VStack {
                    if isLanguageKorean() {
                        HStack {
                            FontText(text: "나는", weight: .bold, size: 15, alignment: .center)
                            FontText(text: LocalizedStringKey(viewModel.resolutionText), weight: .bold, size: 15, alignment: .center)
                        }
                        FontText(text: "사람이 될거야!", weight: .bold, size: 16, alignment: .center)
                    } else {
                        FontText(text: "나는", weight: .bold, size: 15, alignment: .center)
                        FontText(text: LocalizedStringKey(viewModel.resolutionText), weight: .bold, size: 15, alignment: .center)
                    }
                }
                .foregroundStyle(Theme.brightTextColor)
                .frame(width: 300, height: 37)
                .padding(.bottom, 24)
                .padding(.leading, 54)
            }
            .frame(maxWidth: .infinity, maxHeight: 95, alignment: .leading)
        }
        .frame(maxWidth: .infinity, maxHeight: 95)
        .padding(.top, 15)
    }
}
