//
//  Onboard1.swift
//  early-bird
//
//  Created by JAYOU KOO on 4/9/25.
//
import SwiftUI

struct Onboard3View: View {
    @ObservedObject var viewModel: Onboard3ViewModel
    
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
                    FontText(text: "나는 이제 얼리버드와", weight: .bold, size: 28)
                        .foregroundColor(Theme.mainTextColor)
                        .padding(.top, 20)
                    
                    CustomTextField(text: $viewModel.inputText, placeholder: "자신과의 약속을 지키는")
                        .focused($focusedField, equals: .mainInput)
                        .submitLabel(.done)
                        .onSubmit {
                            focusedField = nil // ✅ 키보드 내려가기!
                        }
                    
                    if isLanguageKorean(){
                        FontText(text: "사람이 될거야", weight: .bold, size: 28)
                            .foregroundColor(Theme.mainTextColor)
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
                focusedField = .mainInput
            }
        }
    }
}

#Preview {
    let coordinator = OnboardingCoordinator()
    let viewModel = Onboard3ViewModel(coordinator: coordinator)
//    viewModel.startAnimationSequence()
    return Onboard3View(viewModel: viewModel)
}
