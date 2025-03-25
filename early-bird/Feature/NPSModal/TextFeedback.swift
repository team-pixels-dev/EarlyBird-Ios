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
    @EnvironmentObject var appStateManager: AppStateManager
    
    var body: some View {
        VStack(spacing:0) {
            // 멀티라인 텍스트 입력 필드
            TextEditor(text: $inputText)
                .font(.custom("Pretendard-Regular", size: 18))
                .frame(maxHeight: .infinity)
                .scrollContentBackground(.hidden)
                .foregroundColor(Theme.mainTextColor)
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
                
            Button(action: {
                sendTextFeedBack()
            }) {
                Text("제출하기")
                    .frame(maxWidth: .infinity)
                    .frame(height: 48.0)
                    .background(Theme.primaryColor)
                    .foregroundColor(.white)
            }
            
        }
        .frame(width: 342, height: 243)
        .background(Theme.notSelectedColor)
        .cornerRadius(12)
        .shadow(radius: 20)
        .transition(.scale)
        .alert("제출완료", isPresented: $showSubmitAlert) {
            Button("확인", role: .cancel) {
                closeModal()
            }
        } message: {
            Text("소중한 의견 감사합니다.")
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

struct TextFeedbackModal_Previews: PreviewProvider {
    static var previews: some View {
        // 더미용 상태값과 AppStateManager 생성
        StatefulPreviewWrapper(true) { binding in
            TextFeedbackModal(showModal: binding)
                .environmentObject(AppStateManager())
        }
    }
}

// Preview용 Binding 생성 도우미
struct StatefulPreviewWrapper<Value>: View {
    @State var value: Value
    var content: (Binding<Value>) -> AnyView

    init(_ initialValue: Value, content: @escaping (Binding<Value>) -> some View) {
        _value = State(initialValue: initialValue)
        self.content = { binding in AnyView(content(binding)) }
    }

    var body: some View {
        content($value)
    }
}
