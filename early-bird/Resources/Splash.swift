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
        Locale.current.region?.identifier ?? "default"
    }

    var body: some View {
        Image("splash")
            .resizable()
            .scaledToFit()
            .frame(width: 214, height: 80)
            .navigationBarBackButtonHidden()
            .applyBackground()
    }
}


struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
