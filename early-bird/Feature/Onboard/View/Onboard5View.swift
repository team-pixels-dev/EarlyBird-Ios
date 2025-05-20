//
//  Onboard1.swift
//  early-bird
//
//  Created by JAYOU KOO on 4/9/25.
//

import SwiftUI
import Lottie

struct Onboard5View: View {
    @ObservedObject var viewModel: Onboard5ViewModel
    @FocusState var focusedField: Field?
    
    private var fontSize: CGFloat {
        if isLanguageKorean(){
            return 20
        } else {
            return 17
        }
    }

    var body: some View {
        VStack {
            VStack {
                Image("onboardMascot")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .padding(.bottom, 20)
                    .padding(.top, 55)

                Spacer()
            }
            .frame(width: 336, height: 190, alignment: .center) // ✅ alignment 변경 애니메이션
            
            
            if viewModel.showBlock1 {
                FontText(text: "얼리버드와의 두 번째 약속!", weight: .semiBold, size: 20)
                    .foregroundColor(Theme.mainTextColor)
                    .padding(.bottom, 24)
            }
            
            if viewModel.showBlock2 {
                FontText(text: "알림을 켜면, 얼리버드가 함께할게요.", weight: .semiBold, size: fontSize)
                    .foregroundColor(Theme.mainTextColor)
                FontText(text: "혼자서 미루는 걱정은 이제 그만!", weight: .semiBold, size: fontSize)
                    .foregroundColor(Theme.primaryColor)
                
            }
            if viewModel.showBlock3 {
                VStack{
                    ZStack{
                        if viewModel.notiAccessClicked{
                            NotiAccessAnimationWithotEffectView()
                            Color.black.opacity(0.25)
                                .frame(width: 299, height: 190)
                                .cornerRadius(23) // ShadowedRoundedImageView 모양에 맞게 조절
                                .padding()
                                .allowsHitTesting(false) // 버튼 누르기는 방해 안 되도록
                            
                            LottieView(animation: .named("LoadingAnimation"))
                                .animationSpeed(1.0)
                                .playbackMode(
                                    .playing(
                                        .fromProgress(0.25, toProgress: 0.5, loopMode: .playOnce)
                                    )
                                )
                        } else {
                            Button(action: {viewModel.getPermison()}){
                                NotiAccessAnimationView()
                            }
                        }
                    }
                    .frame(height: 210.0)
                    .padding(.top, 30)
                    
                    Spacer()
                    
                    if viewModel.showBlock4 {
                        FontText(text: "나랑 약속한거지?", weight: .semiBold, size: 23)
                            .foregroundColor(Theme.mainTextColor)
                        FontText(text: "그럼, 이제 시작할게!", weight: .semiBold, size: 23)
                            .foregroundColor(Theme.mainTextColor)
                    }
                    
                    Spacer()
                    
                    FontText(text: "개인정보는 안전하게 보호돼요", weight: .semiBold, size: 14)
                        .foregroundColor(Theme.grayColor)
                }
            }
            Spacer()
        }
        .applyBackgroundWhite()
        .onAppear {
            viewModel.startAnimationSequence()
        }
    }
}


#Preview {
    let coordinator = OnboardingCoordinator()
    let viewModel = Onboard5ViewModel(coordinator: coordinator)
//    viewModel.startAnimationSequence()
    return Onboard5View(viewModel: viewModel)
}
