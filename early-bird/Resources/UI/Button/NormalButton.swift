//
//  NormalButton.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/11/25.
//

import SwiftUI

enum NormalButtonType {
    case full
    case middle
    case small
}

struct NormalButton: View {
    var buttonText: LocalizedStringKey
    var buttonAction : () -> Void
    var type: NormalButtonType = .full
    var disabled: Bool
    
    private var buttonSize: (width: CGFloat, height: CGFloat) {
        switch type {
        case .full:
            return (350, 64)
        case .middle:
            return (242, 45)
        case .small:
            return (115, 54)
        }
    }
    
    private var textSize: CGFloat {
        switch type {
        case .full:
            return 30
        case .middle:
            return 20
        case .small:
            return 14
        }
    }
    
    private var backgroundColor: Color {
        if disabled {
            return Theme.grayColor
        } else {
            return Theme.secondaryColor
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
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(backgroundColor) // fill 대신 foregroundColor 사용
                    .frame(width: buttonSize.width, height: buttonSize.height)
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
