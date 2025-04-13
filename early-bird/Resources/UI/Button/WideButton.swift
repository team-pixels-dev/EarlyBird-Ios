//
//  WideButton.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/11/25.
//

import SwiftUI

enum WideButtonType {
    case full
    case middle
}

struct WideButton: View {
    var buttonText: LocalizedStringKey
    var buttonAction : () -> Void
    var type: WideButtonType = .full
    var disabled: Bool
    
    private var buttonSize: (width: CGFloat, height: CGFloat) {
        switch type {
        case .full:
            return (350, 64)
        case .middle:
            return (242, 45)
        }
    }
    
    private var textSize: CGFloat {
        switch type {
        case .full:
            return 30
        case .middle:
            return 20
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
        Button(action: buttonAction){
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(backgroundColor) // fill 대신 foregroundColor 사용
                    .frame(width: buttonSize.width, height: buttonSize.height)
                    .shadow(color: showdowColor, radius: 0, x: 1, y: 8)
                    Text(buttonText)
                    .font(.custom("Pretendard-Bold", size: textSize))
                    .foregroundColor(Theme.brightTextColor)
            }
        }.disabled(disabled)
    }
}

#Preview {
    WideButton(buttonText: "test", buttonAction: {}, disabled: false)
}
