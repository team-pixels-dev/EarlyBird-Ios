import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Users/jayoukoo/Documents/etc/team_pixel/early-bird/early-bird/early-bird/Resources/Splash.swift", line: 1)
//
//  Splash.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/11/25.
//

import SwiftUI

struct SplashView: View {
    // 현재 국가 코드 가져오기
    private var regionCode: String {
        Locale.current.region?.identifier ?? __designTimeString("#3479_0", fallback: "default")
    }

    var body: some View {
        Image(__designTimeString("#3479_1", fallback: "splash"))
            .resizable()
            .scaledToFit()
            .frame(width: __designTimeInteger("#3479_2", fallback: 214), height: __designTimeInteger("#3479_3", fallback: 80))
            .navigationBarBackButtonHidden()
            .applyBackground()
    }
}


struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
