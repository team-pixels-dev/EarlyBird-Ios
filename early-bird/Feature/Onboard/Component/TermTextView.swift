//
//  TermText.swift
//  early-bird
//
//  Created by JAYOU KOO on 5/18/25.
//
import SwiftUI

struct TermText: View {
    @Binding var isChecked: Bool
    
    let preferredLanguage = Locale.preferredLanguages.first ?? "unknown"
    
    var body: some View {
        HStack {
            if isEuropeanRegion() {
                Toggle("", isOn: $isChecked)
                    .toggleStyle(CheckBoxToggleStyle())
                if (isLanguageKorean()) {
                    TermTextKO()
                        .padding(.leading, 10)
                } else {
                    TermTextEN()
                        .padding(.leading, 10)
                }
                    
            } else {
                if (isLanguageKorean()) {
                    TermTextKO()
                } else {
                    TermTextEN()
                }
            }
        }.onAppear {
            if !isEuropeanRegion() {
                self.isChecked = true
            }
        }
            
    }
    
    func openTerms() {
        print("open terms")
        if let url = URL(string: NSLocalizedString("terms_url", comment: "")) {
            UIApplication.shared.open(url)
        }
    }
    
    func openPrivacyPolicy() {
        print("open privacy policy")
        if let url = URL(string: NSLocalizedString("privacy_policy_url", comment: "")) {
            UIApplication.shared.open(url)
        }
    }
    
    func TermTextEU() -> some View {
        VStack(alignment: .leading){
            HStack(spacing: 0){
                FontText(text: "I agree to EarlyBird's ", size: 12, alignment: .center)
                    .foregroundStyle(Theme.descriptionTextColor)
                Button(action: openTerms){
                    FontText(text: "Terms of Service", size: 12, alignment: .leading)
                        .foregroundStyle(Theme.descriptionTextColor)
                        .underline()
                        .padding(0)
                }
            }
            HStack(spacing: 0){
                FontText(text: "and", size: 12, alignment: .center)
                    .foregroundStyle(Theme.descriptionTextColor)
                FontText(text: " ", size: 12, alignment: .center)
                    .foregroundStyle(Theme.descriptionTextColor)
                    .padding(0)
                Button(action: openPrivacyPolicy){
                    FontText(text: "Privacy Policy.", size: 12, alignment: .center)
                        .foregroundStyle(Theme.descriptionTextColor)
                        .underline()
                        .padding(0)
                }
            }
        }
    }
    
    
    func TermTextEN() -> some View {
        VStack{
            FontText(text: "By tapping Start, you agree to", size: 12, alignment: .center)
                .foregroundStyle(Theme.descriptionTextColor)
            HStack(spacing: 0){
                Spacer()
                FontText(text: "EarlyBird’s ", size: 12, alignment: .center)
                    .foregroundStyle(Theme.descriptionTextColor)
                    .padding(0)
                Button(action: openTerms){
                    FontText(text: "Terms of Service", size: 12, alignment: .leading)
                        .foregroundStyle(Theme.descriptionTextColor)
                        .underline()
                        .padding(0)
                }
                FontText(text: " and", size: 12, alignment: .center)
                    .foregroundStyle(Theme.descriptionTextColor)
                FontText(text: " ", size: 12, alignment: .center)
                    .foregroundStyle(Theme.descriptionTextColor)
                    .padding(0)
                Button(action: openPrivacyPolicy){
                    FontText(text: "Privacy Policy.", size: 12, alignment: .center)
                        .foregroundStyle(Theme.descriptionTextColor)
                        .underline()
                        .padding(0)
                }
                Spacer()
            }
        }
    }
    
    func TermTextKO() -> some View {
        VStack{
            HStack(spacing: 0){
                FontText(text: "시작 버튼을 누르면 얼리버드의 ", size: 12, alignment: .center)
                    .foregroundStyle(Theme.descriptionTextColor)
                Button(action: openTerms){
                    FontText(text: "이용약관", size: 12, alignment: .leading)
                        .foregroundStyle(Theme.descriptionTextColor)
                        .underline()
                        .padding(0)
                }
                FontText(text: "과", size: 12, alignment: .center)
                    .foregroundStyle(Theme.descriptionTextColor)
            }
            HStack(spacing: 0){
                Button(action: openPrivacyPolicy){
                    FontText(text: "개인정보처리방침", size: 12, alignment: .center)
                        .foregroundStyle(Theme.descriptionTextColor)
                        .underline()
                        .padding(0)
                }
                FontText(text: "에 동의하게 돼요", size: 12, alignment: .center)
                    .foregroundStyle(Theme.descriptionTextColor)
            }
        }
    }
}
