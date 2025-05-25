//
//  TextFeedBack.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/16/25.
//

import SwiftUI

struct TextFeedBackJson: Codable {
    var comment: String
    var clientId : String
    var createdAt : String
}

struct TextFeedbackModal: View {
    @State private var showSubmitAlert = false
    @Binding var showModal: Bool
    @State private var submittedText: String = ""
    @State private var inputText: String = ""
    var appStateManager = AppStateManager.shared
    
    @FocusState var focusedField: Field?
    
    
    var body: some View {
        VStack(spacing:0) {
            // 멀티라인 텍스트 입력 필드
            TextEditor(text: $inputText)
                .font(.custom("Pretendard-Regular", size: 18))
                .frame(maxHeight: .infinity)
                .scrollContentBackground(.hidden)
                .foregroundStyle(Theme.mainTextColor)
                .background(Theme.notSelectedColor)
                .padding(.leading, 20.0)
                .padding(.top, 16.0)
                .cornerRadius(8)
                .overlay(alignment: .topLeading) {
                    Text("서비스에 대한 피드백을 300자 이내로 작성해주세요")
                        .padding([.top, .leading], 25.0)
                        .foregroundStyle(inputText.isEmpty ? .gray : .clear)
                        .font(.custom("Pretendard-Ragular", size: 14))
                }
                .focused($focusedField, equals: .mainInput)
                
            Button(action: {
                sendTextFeedBack()
            }) {
                Text("submit")
                    .frame(maxWidth: .infinity)
                    .frame(height: 48.0)
                    .background(Theme.primaryColor)
                    .foregroundStyle(.white)
            }
            
        }
        .frame(width: 342, height: 243)
        .background(Theme.notSelectedColor)
        .cornerRadius(12)
        .shadow(radius: 20)
        .transition(.scale)
        .alert("submitted", isPresented: $showSubmitAlert) {
            Button("Confirm", role: .cancel) {
                closeModal()
            }
        } message: {
            Text("소중한 의견 감사합니다.")
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                focusedField = .mainInput
            }
        }
    }
    
    func closeModal() {
        showModal = false
        appStateManager.lastAppState = .home
    }
    
    func sendTextFeedBack() {
        if (inputText.isEmpty){
            closeModal()
            return
        }
        
        submittedText = inputText
        
        let TextFeedBackData = TextFeedBackJson(
            comment: submittedText,
            clientId: ClientIDManager.getClientID(),
            createdAt: formatDate(Date())
        )
        
        sendPostRequest(to: "/api/v1/feedbacks/comments", with: TextFeedBackData){ result in
            switch result {
            case .success(_):
                showSubmitAlert = true
            case .failure(_):
                closeModal()
                break
            }
        }
    }
}
