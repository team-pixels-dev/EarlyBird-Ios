//
//  Onboard1.swift
//  early-bird
//
//  Created by JAYOU KOO on 4/9/25.
//

import SwiftUI
import Lottie

struct Onboard_4View: View {
    @ObservedObject var viewModel: Onboard4ViewModel
    @FocusState var focusedField: Field?

    @State private var isCentered = false
    @State private var mascotPadding = 70.0
    
    private var fontSize: CGFloat {
        if Locale.current.language.languageCode?.identifier == "ko"{
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
                    .padding(.top, mascotPadding)

                Spacer()
            }
            .frame(width: 336, height: 190, alignment: isCentered ? .center : .leading) // ✅ alignment 변경 애니메이션
            .animation(.easeInOut(duration: 0.6), value: isCentered) // ✅ 애니메이션 트리거
            
            
            if viewModel.showBlock1 {
                FontText(text: "얼리버드야, 나 이제부터 진짜 약속할게.", weight: .semiBold, size: 20)
                    .foregroundColor(Theme.mainTextColor)
                    .padding(.bottom, 24)
            }
            
            if viewModel.showBlock2 {
                FontText(text: "스크린타임 설정은 우리 둘 사이, ", weight: .semiBold, size: fontSize)
                    .foregroundColor(Theme.mainTextColor)
                HStack(spacing: 0.0){
                    Spacer()
                    FontText(text: "미루기를 끝내기 위한 첫번째 약속", weight: .semiBold, size: fontSize)
                        .foregroundColor(Theme.primaryColor)
                    if Locale.current.language.languageCode?.identifier == "ko"{
                        FontText(text: "이야.", weight: .semiBold, size: fontSize)
                            .foregroundColor(Theme.mainTextColor)
                    }
                    Spacer()
                }
                .padding(0.0)
                
            }
            if viewModel.showBlock3 {
                Spacer()
                
                ZStack{
                    if viewModel.screenTimeAccessClicked{
                        ShadowedRoundedImageViewWithotEffect()
                        Color.black.opacity(0.25)
                                    .frame(width: 263*1.02, height: 198*1.02)
                                    .cornerRadius(20) // ShadowedRoundedImageView 모양에 맞게 조절
                                    .padding()
                                    .allowsHitTesting(false) // 버튼 누르기는 방해 안 되도록
                        
                        LottieView(animation: .named("LoadingAnimation"))
                            .animationSpeed(0.75)
                            .playbackMode(
                                .playing(
                                    .fromProgress(0.25, toProgress: 0.5, loopMode: .playOnce)
                                )
                            )
                    } else {
                        Button(action: {viewModel.getScreenTimePermison()}){
                            ShadowedRoundedImageView()
                                .padding()
                        }
                    }
                }
                
                Spacer()
                
                FontText(text: "나랑 약속한거지?", weight: .semiBold, size: 23)
                    .foregroundColor(Theme.mainTextColor)
                FontText(text: "그럼, 이제 출발이야!", weight: .semiBold, size: 23)
                    .foregroundColor(Theme.mainTextColor)
                    .padding(.bottom, 4.0)
                FontText(text: "개인정보는 안전하게 보호돼요", weight: .semiBold, size: 14)
                    .foregroundColor(Theme.grayColor)
            }
            Spacer()
        }
        .applyBackgroundWhite()
        .onAppear {
            viewModel.startAnimationSequence()

            withAnimation {
                isCentered = true
                mascotPadding = 55.0
            }
        }
    }
}


#Preview {
    let coordinator = OnboardingCoordinator()
    let viewModel = Onboard4ViewModel(coordinator: coordinator)
//    viewModel.startAnimationSequence()
    return Onboard_4View(viewModel: viewModel)
}
