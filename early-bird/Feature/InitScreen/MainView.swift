//
//  MainView.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/17/25.
//
import SwiftUI

struct MainView: View {
    var body: some View {
        VStack(spacing: 0) {
            MainHeaderView().padding(.top, 24)
            
            NavigationLink(destination: TimerView()) {
                CardViewVer2(
                    buttonText: "지금 당장 시작하기",
                    description: "자괴감 방지 기능 스트레스 감소",
                    buttonAction: {
                        print("지금 당장 시작하기 버튼 클릭")
                    },
                    color: "tint"
                )
                .padding(.bottom, 24)
            }
            
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Theme.appBackgroundColor)
    }
}

struct MainHeaderView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("나는")
                .font(.custom("Pretendard-SemiBold", size: 28))
                .foregroundColor(Theme.mainTextColor1)
            Text("할 일을 미루지 않는")
                .font(.custom("Pretendard-SemiBold", size: 28))
                .foregroundColor(Theme.mainTextColor)
            Text("사람이다.")
                .font(.custom("Pretendard-SemiBold", size: 28))
                .foregroundColor(Theme.mainTextColor1)
        }
        .padding(.bottom, 80)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct CardViewVer2: View {
    let buttonText: String
    let description: String
    let buttonAction: () -> Void
    let color: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 35) {
            Text(description)
                .font(.system(size: 16))
                .foregroundColor(color == "tint" ? Theme.brightTextColor : Theme.mainTextColor2)
            Image("fireIcon")
                .resizable()
                .scaledToFit()
                .frame(width: 34, height: 39)
            HStack {
                Text(buttonText)
                    .font(.system(size: 20))
                    .foregroundColor(Theme.mainTextColor2)
                Image("lineArrowIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            .frame(width: 290, height: 40)
            .background(color == "tint" ? Theme.backgroundColor : Theme.primaryColor)
            .cornerRadius(10)
        }
        .frame(width: 355, height: 232)
        .background(color == "tint" ? Theme.primaryColor : Theme.backgroundColor)
        .cornerRadius(10)
    }
}

// 추가 뷰 및 스타일 정의는 그대로 유지

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
