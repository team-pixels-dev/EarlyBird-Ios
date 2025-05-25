//
//  RoundedButton.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/11/25.
//

import SwiftUI

enum RoundedButtonType {
    case full
    case middleFull
    case middle
    case small
}

struct RoundedButton: View {
    var buttonText: LocalizedStringKey
    var buttonTextColor: Color = Theme.brightTextColor
    var buttonAction : () -> Void
    var type: RoundedButtonType = .full
    var disabled: Bool = false
    var shadow: Bool = true
    
    private var buttonSize: (width: CGFloat, height: CGFloat) {
        switch type {
        case .full:
            return (350, 64)
        case .middleFull:
            return (303, 51)
        case .middle:
            return (242, 45)
        case .small :
            return (178, 48)
        }
        
    }
    
    private var textSize: CGFloat {
        switch type {
        case .full:
            return 30
        case .middleFull:
            return 24
        case .middle:
            return 20
        case .small:
            return 24
        }
    }
    
    private var backgroundColor: Color {
        if disabled {
            return Theme.grayColor
        } else {
            return Theme.primaryColor
        }
    }
    
    private var showdowColor: Color {
        if disabled {
            return Theme.descriptionTextColor
        } else {
            return Theme.secondaryColor
        }
    }
    
    var body: some View {
        if shadow {
            Button(action: buttonAction){
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundStyle(backgroundColor) // fill 대신 foregroundStyle 사용
                        .frame(width: buttonSize.width, height: buttonSize.height)
                        .shadow(color: showdowColor, radius: 0, x: 1, y: 8)
                        Text(buttonText)
                        .font(.custom("Pretendard-Bold", size: textSize))
                        .foregroundStyle(Theme.brightTextColor)
                }
            }.disabled(disabled)
        } else {
            Button(action: buttonAction){
                Text(buttonText)
                .font(.custom("Pretendard-Bold", size: textSize))
                .foregroundStyle(Theme.brightTextColor)
            }
            .frame(width: buttonSize.width, height: buttonSize.height)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .disabled(disabled)
        }
        
    }
}

#Preview {
    RoundedButton(buttonText: "test", buttonAction: {}, disabled: false)
}
