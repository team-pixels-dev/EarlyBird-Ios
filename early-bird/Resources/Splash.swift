//
//  Splash.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/11/25.
//

import SwiftUI

struct SplashView: View {
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
