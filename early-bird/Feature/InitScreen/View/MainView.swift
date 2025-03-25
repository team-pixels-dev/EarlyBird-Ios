//
//  MainView.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/17/25.
//
import SwiftUI

struct MainView: View {
    @EnvironmentObject var appStateManager: AppStateManager
    @State private var gotoTimerView: Bool = false
    @State private var gotoCompleteView: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            MainHeaderView().padding(.top, 54)
            
            NavigationLink(destination: TimerView(appStateManager: appStateManager)) {
                CardViewVer(
                    buttonText: "지금 2분 집중 시작",
                    description: "자괴감 방지 가능, 스트레스 감소",
                    buttonAction: {
                        print("지금 당장 시작하기 버튼 클릭")
                    },
                    color: "tint"
                )
                .padding(.bottom, 24)
            }
            
            // TimerView 이동 준비
            NavigationLink(destination: TimerView(appStateManager: appStateManager), isActive: $gotoTimerView){
                EmptyView()
            }
            
            // CompleteView 이동 준비
            NavigationLink(destination: CompleteView(), isActive: $gotoCompleteView){
                EmptyView()
            }
            
            Spacer()
        }
        .applyBackground()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .navigationBarBackButtonHidden()
        .onAppear{
            // lastAppState가 .timerStarted일 경우
            if(appStateManager.lastAppState == .timerStarted){
                // 타이머 종료 시점까지 남음 시간 계산
                let timeRemaining = Int(appStateManager.timerEndTime.timeIntervalSince(Date()) * 1000)
                
                // 타이머 종료 시점에 임계함에 따라 타이머 또는 완료 화면으로 이동
                if (timeRemaining > 0) {
                    gotoTimerView = true
                } else {
                    gotoCompleteView = true
                }
            }
        }
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
        .padding(.bottom, 70)
        .padding(.leading, 25)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct CardViewVer: View {
    let buttonText: String
    let description: String
    let buttonAction: () -> Void
    let color: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 45) {
            Text(description)
                .font(.custom("Pretendard-SemiBold", size: 16))
                .foregroundColor(color == "tint" ? Theme.brightTextColor : Theme.mainTextColor2)
            Image("LockIcon")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 67)
            HStack {
                Text(buttonText)
                    .font(.custom("Pretendard-Bold", size: 20))
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
        .frame(width: 366, height: 270)
        .background(color == "tint" ? Theme.primaryColor : Theme.backgroundColor)
        .cornerRadius(10)
    }
}

#Preview {
    MainView()
        .environmentObject(AppStateManager())
}

