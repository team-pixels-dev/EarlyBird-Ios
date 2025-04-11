import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Users/jayoukoo/Documents/etc/team_pixel/early-bird/early-bird/early-bird/Feature/InitScreen/View/MainView.swift", line: 1)
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
    @State private var showAlert = false
    @State private var showPasswordPrompt = false
    
    private let shakePublisher = NotificationCenter.default.publisher(for: .deviceDidShakeNotification)
    
    var body: some View {
        VStack(spacing: __designTimeInteger("#7303_0", fallback: 0)) {
            MainHeaderView().padding(.top, __designTimeInteger("#7303_1", fallback: 54))
            
            NavigationLink(destination: TimerView(appStateManager: appStateManager)) {
                CardViewVer(
                    buttonText: __designTimeString("#7303_2", fallback: "main_start_button_text1"),
                    description: __designTimeString("#7303_3", fallback: "main_card_description1"),
                    buttonAction: {
                        print(__designTimeString("#7303_4", fallback: "지금 당장 시작하기 버튼 클릭"))
                    },
                    color: __designTimeString("#7303_5", fallback: "tint")
                )
                .padding(.bottom, __designTimeInteger("#7303_6", fallback: 24))
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
                let timeRemaining = Int(appStateManager.timerEndTime.timeIntervalSince(Date()) * __designTimeInteger("#7303_7", fallback: 1000))
                
                // 타이머 종료 시점에 임계함에 따라 타이머 또는 완료 화면으로 이동
                if (timeRemaining > __designTimeInteger("#7303_8", fallback: 0)) {
                    gotoTimerView = __designTimeBoolean("#7303_9", fallback: true)
                } else {
                    gotoCompleteView = __designTimeBoolean("#7303_10", fallback: true)
                }
            }   
        }
        .onReceive(shakePublisher) { _ in
            showAlert = __designTimeBoolean("#7303_11", fallback: true)
        }
        .teamMemberAlert(isPresented: $showAlert, showPasswordPrompt: $showPasswordPrompt)
        .sheet(isPresented: $showPasswordPrompt) {
            PasswordPromptSheet(isPresented: $showPasswordPrompt)
        }
    }
}

struct MainHeaderView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text(__designTimeString("#7303_12", fallback: "나는"))
                .font(.custom(__designTimeString("#7303_13", fallback: "Pretendard-SemiBold"), size: __designTimeInteger("#7303_14", fallback: 28)))
                .foregroundColor(Theme.mainTextColor1)
            Text(__designTimeString("#7303_15", fallback: "할 일을 미루지 않는"))
                .font(.custom(__designTimeString("#7303_16", fallback: "Pretendard-SemiBold"), size: __designTimeInteger("#7303_17", fallback: 28)))
                .foregroundColor(Theme.mainTextColor)
            Text(__designTimeString("#7303_18", fallback: "사람이다."))
                .font(.custom(__designTimeString("#7303_19", fallback: "Pretendard-SemiBold"), size: __designTimeInteger("#7303_20", fallback: 28)))
                .foregroundColor(Theme.mainTextColor1)
        }
        .padding(.bottom, __designTimeInteger("#7303_21", fallback: 70))
        .padding(.leading, __designTimeInteger("#7303_22", fallback: 25))
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct CardViewVer: View {
    let buttonText: LocalizedStringKey
    let description: LocalizedStringKey
    let buttonAction: () -> Void
    let color: LocalizedStringKey
    
    var body: some View {
        VStack(alignment: .center, spacing: __designTimeInteger("#7303_23", fallback: 45)) {
            Text(description)
                .font(.custom(__designTimeString("#7303_24", fallback: "Pretendard-SemiBold"), size: __designTimeInteger("#7303_25", fallback: 16)))
                .foregroundColor(color == __designTimeString("#7303_26", fallback: "tint") ? Theme.brightTextColor : Theme.mainTextColor2)
            Image(__designTimeString("#7303_27", fallback: "LockIcon"))
                .resizable()
                .scaledToFit()
                .frame(width: __designTimeInteger("#7303_28", fallback: 50), height: __designTimeInteger("#7303_29", fallback: 67))
            HStack {
                Text(buttonText)
                    .font(.custom(__designTimeString("#7303_30", fallback: "Pretendard-Bold"), size: __designTimeInteger("#7303_31", fallback: 20)))
                    .foregroundColor(Theme.mainTextColor2)
                Image(__designTimeString("#7303_32", fallback: "lineArrowIcon"))
                    .resizable()
                    .scaledToFit()
                    .frame(width: __designTimeInteger("#7303_33", fallback: 24), height: __designTimeInteger("#7303_34", fallback: 24))
            }
            .frame(width: __designTimeInteger("#7303_35", fallback: 290), height: __designTimeInteger("#7303_36", fallback: 40))
            .background(color == __designTimeString("#7303_37", fallback: "tint") ? Theme.backgroundColor : Theme.primaryColor)
            .cornerRadius(__designTimeInteger("#7303_38", fallback: 10))
        }
        .frame(width: __designTimeInteger("#7303_39", fallback: 366), height: __designTimeInteger("#7303_40", fallback: 270))
        .background(color == __designTimeString("#7303_41", fallback: "tint") ? Theme.primaryColor : Theme.backgroundColor)
        .cornerRadius(__designTimeInteger("#7303_42", fallback: 10))
    }
}

#Preview {
    MainView()
        .environmentObject(AppStateManager())
}

