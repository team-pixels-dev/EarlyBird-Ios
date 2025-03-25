//
//  CheckTeamMemberModal.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/25/25.
//
import SwiftUI

struct TeamMemberAlertView: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var showPasswordPrompt: Bool
    @AppStorage("isTeamMember") private var isTeamMember: Bool = false

    func body(content: Content) -> some View {
        content.alert("EarlyBird 팀원이신가요?", isPresented: $isPresented) {
            Button("네") {
                showPasswordPrompt = true
            }
            Button("아니요", role: .cancel) {
                isTeamMember = false
            }
        }
    }
}

extension View {
    func teamMemberAlert(isPresented: Binding<Bool>, showPasswordPrompt: Binding<Bool>) -> some View {
        self.modifier(TeamMemberAlertView(isPresented: isPresented, showPasswordPrompt: showPasswordPrompt))
    }
}

struct PasswordPromptSheet: View {
    @Binding var isPresented: Bool
    @AppStorage("isTeamMember") private var isTeamMember: Bool = false
    @State private var password: String = ""
    @State private var showResultAlert: Bool = false
    @State private var resultMessage: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("코드를 입력해주세요")
                .font(.headline)
            SecureField("코드", text: $password)
                .textFieldStyle(.roundedBorder)
                .padding()
            HStack {
                Button("취소") {
                    password = ""
                    resultMessage = "팀원 인증이 완료되었습니다."
                }
                Button("확인") {
                    isTeamMember = (password == "changetheworld")
                    password = ""
                    resultMessage = "코드가 일치하지 않습니다."
                }
            }
        }
        .padding()
        .alert(isPresented: $showResultAlert) {
            Alert(title: Text(resultMessage), dismissButton: .default(Text("확인")) {
                isPresented = false
            })
        }
    }
}
