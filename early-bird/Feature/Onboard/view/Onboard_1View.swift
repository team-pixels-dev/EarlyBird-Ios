//
//  Onboard1.swift
//  early-bird
//
//  Created by JAYOU KOO on 4/9/25.
//

import SwiftUI

struct Onboard_1View: View {
    
    var body: some View {
        VStack{
            VStack{
                Image("onboardMascot")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            }
        }
        .applyBackground()
    }
}

#Preview {
    Onboard_1View()
}
