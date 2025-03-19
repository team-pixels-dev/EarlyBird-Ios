//
//  TimerView.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/9/25.
//
import SwiftUI

struct TimerView: View {
    @EnvironmentObject var appStateManager: AppStateManager
    @StateObject private var viewModel: TimerViewModel

    init(appStateManager: AppStateManager) {
        _viewModel = StateObject(wrappedValue: TimerViewModel(appStateManager: appStateManager))
    }
    
    var body: some View {
        ZStack() {
            HStack(alignment: .bottom, spacing:0){
                Text(viewModel.formattedTime)
                    .font(.custom("Pretendard-ExtraBold", size: 72))
                    .foregroundColor(viewModel.timerActive ? Theme.wrongColor : Theme.mainTextColor2)
                Text(viewModel.formattedTimeMs)
                    .font(.custom("Pretendard-ExtraBold", size: 36))
                    .foregroundColor(viewModel.timerActive ? Theme.wrongColor : Theme.mainTextColor2)
                    .padding(.bottom, 10.0)
            }
            if (!viewModel.timerActive){
                WideButton(
                    buttonText: "시작!", buttonAction: {viewModel.startTimer(autoStart: false)}, disabled: false
                )
                .disabled(viewModel.timerActive)
                .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 170)
            }
            
            NavigationLink(destination: CompleteView(), isActive: $viewModel.showNextView) {
                EmptyView()
            }
        }
        .navigationBarBackButtonHidden()
    }
}
