import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Users/jayoukoo/Documents/etc/team_pixel/early-bird/early-bird/early-bird/Feature/Onboard/view/Onboard_1View.swift", line: 1)
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
                Image(__designTimeString("#7515_0", fallback: "onboardMascot"))
                    .resizable()
                    .scaledToFit()
                    .frame(width: __designTimeInteger("#7515_1", fallback: 100), height: __designTimeInteger("#7515_2", fallback: 100))
            }
        }
        .applyBackground()
    }
}

#Preview {
    Onboard_1View()
}
