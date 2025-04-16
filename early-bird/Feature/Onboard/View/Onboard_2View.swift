//
//  Onboard1.swift
//  early-bird
//
//  Created by JAYOU KOO on 4/9/25.
//
import SwiftUI

struct Onboard_2View: View {
    @ObservedObject var viewModel: Onboard2ViewModel
    
    @FocusState var focusedField: Field?

    var body: some View {
        VStack {
            OnboardingConversationView(
                messages: viewModel.conversation,
                visibleCount: viewModel.visibleCount
            )

            Spacer()

            if viewModel.showTextInput {
                VStack {
                    if Locale.current.language.languageCode?.identifier == "ko" {
                        FontText(text: "나는 더 이상 미뤄서 스트레스 받기 싫어!", weight: .bold, size: 18)
                            .foregroundColor(Theme.mainTextColor)
                    }
                    FontText(text: "왜냐하면...", weight: .bold, size: 22)
                        .foregroundColor(Theme.mainTextColor)

                    Spacer()

                    CustomBigTextField(text: $viewModel.inputText, placeholder: "\"하루가 그냥 낭비한 것 같아 허무해서…\"\n\"생각만 하다 결국 아무것도 못 해서…\"\n\"또 못 지켰다는 생각에 자존감 하락..\"")
                        .focused($focusedField, equals: .mainInput)
                        .submitLabel(.done)
                        .onSubmit {
                            focusedField = nil // ✅ 키보드 내려가기!
                        }

                    Spacer()

                    WideButton(buttonText: "다음", buttonAction: viewModel.submit, type: .middle, disabled: viewModel.inputText.isEmpty)
                }
                .frame(height: 340.0)
            }
        }
        .applyBackgroundWhite()
        .onAppear {
            viewModel.startAnimationSequence()
            DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                    focusedField = .mainInput
                }
        }
    }
}

#Preview {
    let coordinator = OnboardingCoordinator()
    let viewModel = Onboard2ViewModel(coordinator: coordinator)
    viewModel.startAnimationSequence()
    return Onboard_2View(viewModel: viewModel)
}
