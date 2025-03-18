//
//  TimerView.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/9/25.
//
import SwiftUI

struct TimerView: View {
    @StateObject private var viewModel = TimerViewModel()
    
    var body: some View {
        ZStack() {
            HStack(alignment: .bottom, spacing:0){
                Text(viewModel.formattedTime)
                    .font(.custom("Pretendard-ExtraBold", size: 72))
                    .foregroundColor(Theme.wrongColor)
                Text(viewModel.formattedTimeMs)
                    .font(.custom("Pretendard-ExtraBold", size: 36))
                    .foregroundColor(Theme.wrongColor)
                    .padding(.bottom, 10.0)
                
            }
            WideButton(
                buttonText: "시작!", buttonAction: viewModel.startTimer, disabled: false
            )
            .disabled(viewModel.timerActive)
            .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 170)
            
            NavigationLink(destination: CompleteView(), isActive: $viewModel.showNextView) {
                EmptyView()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
