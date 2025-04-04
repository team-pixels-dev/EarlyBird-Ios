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
        let imageName = viewModel.timerActive ? "mascotAngryFace" : "mascotNormalFace"
        let imageSize = viewModel.timerActive ? CGSize(width: 161, height: 172) : CGSize(width: 159, height: 150)
        
        ZStack() {
            VStack{
                VStack{
                    Spacer()
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: imageSize.width, height: imageSize.height)
                        .transition(.opacity)
                }
                .animation(.easeInOut(duration: 0.3), value: viewModel.timerActive)
                .frame(height: 180)
                .padding(.bottom, 40)
                .padding(.top, 136)
                
                HStack(alignment: .bottom, spacing:0){
                    Text(viewModel.formattedTime)
                        .font(.custom("Pretendard-ExtraBold", size: 72))
                        .foregroundColor(viewModel.timerActive ? Theme.wrongColor : Theme.mainTextColor2)
                    Text(viewModel.formattedTimeMs)
                        .font(.custom("Pretendard-ExtraBold", size: 36))
                        .foregroundColor(viewModel.timerActive ? Theme.wrongColor : Theme.mainTextColor2)
                        .padding(.bottom, 10.0)
                }
                Spacer()
            }
            if (!viewModel.timerActive){
                VStack{
                    Spacer()
                    WideButton(
                        buttonText: "timer_start_button_text", buttonAction: {viewModel.checkPermissionsAndStartTimer(autoStart: false)}, disabled: false
                    )
                    .disabled(viewModel.timerActive)
                    .padding(.bottom, 40)
                }
            }
            
            NavigationLink(destination: CompleteView(), isActive: $viewModel.showNextView) {
                EmptyView()
            }
        }
        .applyBackground()
        .alert("필수 권한이 없습니다.", isPresented: $viewModel.showPermissionErrorMsgModal) {
            Button("확인") {
                viewModel.tryGetPermission()
                viewModel.showPermissionErrorMsgModal = false
            }
        } message: {
            Text("앱 잠금 기능을 위해 필수 권한이 필요해요.\n권한 : FamilyControls, 알림")
        }
        .navigationBarBackButtonHidden()
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyAppStateManager = AppStateManager() // 필요 시 초기화 파라미터 추가
        TimerView(appStateManager: dummyAppStateManager)
            .environmentObject(dummyAppStateManager)
    }
}
