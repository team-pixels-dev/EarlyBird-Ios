//
//  CheckBoxToggleStyle.swift
//  early-bird
//
//  Created by JAYOU KOO on 5/18/25.
//

import SwiftUI

struct CheckBoxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            Image(configuration.isOn ? "checkBoxOn" : "checkBoxOff")
                .resizable()
                .frame(width: 18, height: 18)
        }
    }
}
