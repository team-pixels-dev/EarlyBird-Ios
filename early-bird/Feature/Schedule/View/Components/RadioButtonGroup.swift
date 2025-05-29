//
//  RadioButtonGroup.swift
//  early-bird
//
//  Created by JAYOU KOO on 5/25/25.
//


import SwiftUI

struct RadioButtonGroup: View {
    @Binding var selection: Int
    
    enum Option: String, CaseIterable {
            case first  = "반복 알람"
            case second = "한 번 알람"
            
            // 각 케이스에 대응하는 이미지 이름
            var imageName: String {
                switch self {
                case .first:
                    return "repeat"
                case .second:
                    return "bell"
                }
            }
        
        }

    @State private var selected: Option = .first

    var body: some View {
        HStack(spacing: 20) {
            ForEach(Option.allCases, id: \.self) { option in
                Button(action: {
                    selected = option
                }) {
                    VStack{
                        Image(option.imageName)
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(selected == option
                                 ? Theme.brightTextColor
                                 : Theme.mainTextColor2
                            )
                            .frame(width: 24, height: 24)
                            
                        FontText(text: LocalizedStringKey(option.rawValue), weight: .semiBold, size: 12)
                    }
                    .frame(width: 121, height: 65)
                    .background(selected == option
                        ? Theme.primaryColor
                        : Theme.notSelectedColor)
                    .foregroundStyle(selected == option
                        ? Theme.brightTextColor
                        : Theme.mainTextColor2)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
    }
}
