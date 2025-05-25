//
//  RoundedButton.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/11/25.
//

import SwiftUI

enum RectangleButtonType {
    case full
    case middleFull
    case middle
}

struct RectangleButton: View {
    var buttonText: LocalizedStringKey
    var buttonTextColor: Color = Theme.brightTextColor
    var buttonAction : () -> Void
    var type: RectangleButtonType = .full
    var disabled: Bool = false
    var backgroundColor: Color = Theme.primaryColor
    var showdowColor: Color = Theme.secondaryColor
    
    private var buttonSize: (width: CGFloat, height: CGFloat) {
        switch type {
        case .full:
            return (355, 106)
        case .middleFull:
            return (303, 51)
        case .middle:
            return (242, 45)
        }
    }
    
    private var textSize: CGFloat {
        switch type {
        case .full:
            return 24
        case .middleFull:
            return 24
        case .middle:
            return 20
        }
    }
    
    var body: some View {
        Button(action: buttonAction){
            ZStack {
                RoundedRectangle(cornerRadius: 11)
                    .foregroundStyle(backgroundColor) // fill 대신 foregroundStyle 사용
                    .frame(width: buttonSize.width, height: buttonSize.height)
                    .shadow(color: showdowColor, radius: 8, x: 0, y: 5)
                HStack{
                    Text(buttonText)
                        .font(.custom("Pretendard-Bold", size: textSize))
                        .foregroundStyle(buttonTextColor)
                    Image("rightVector")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(buttonTextColor)
                        .frame(height: 22)
                        
                }
            }
        }.disabled(disabled)
    }
}

#Preview {
    RoundedButton(buttonText: "test", buttonAction: {}, disabled: false)
}
