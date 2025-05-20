////
////  Splash.swift
////  early-bird
////
////  Created by JAYOU KOO on 3/11/25.
////
//
//import SwiftUI
//
//struct SplashViewOld: View {
//    // 현재 국가 코드 가져오기
//    let preferredLanguage = Locale.preferredLanguages.first ?? "unknown"
//
//    var body: some View {
//        // 영국(en-GB) 영어에 대한 이미지 렌더를 따로 처리
//        Image(preferredLanguage == "en-GB" ? "splash_uk" : "splash")
//            .resizable()
//            .scaledToFit()
//            .frame(height: 80)
//            .navigationBarBackButtonHidden()
//            .applyBackground()
//            .onAppear {
//                print("("+preferredLanguage+")")
//            }
//    }
//}
//
//
//struct SplashView_Previews: PreviewProvider {
//    static var previews: some View {
//        SplashView()
//    }
//}
