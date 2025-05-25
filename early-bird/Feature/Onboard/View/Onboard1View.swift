//
//  Onboard1View.swift
//  early-bird
//
//  Created by JAYOU KOO on 4/9/25.
//

import SwiftUI

struct Onboard1View: View {
    @ObservedObject var viewModel: Onboard1ViewModel
    
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
                    FontText(text: "내가 미루는 이유", weight: .bold, size: 22)
                        .foregroundColor(Theme.mainTextColor)

                    Spacer()
                    
                    CustomBigTextField(text: $viewModel.inputText, placeholder: "\"유튜브에 정신 팔려서…\"\n\"계획만 세우다 끝나서…\"\n\"잘할 자신이 없어서…\"")
                        .focused($focusedField, equals: .mainInput)
                        .submitLabel(.done)
                        .onSubmit {
                            focusedField = nil // ✅ 키보드 내려가기!
                        }

                    Spacer()

                    RoundedButton(
                        buttonText: "다음",
                        buttonAction: {
                            viewModel.submit()
                        },
                        type: .middle,
                        disabled: viewModel.inputText.isEmpty
                    )
                }
                .frame(height: 329)
                .padding(.bottom, 0.0)
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
    let viewModel = Onboard1ViewModel(coordinator: coordinator)
    viewModel.startAnimationSequence()
    return Onboard1View(viewModel: viewModel)
}
