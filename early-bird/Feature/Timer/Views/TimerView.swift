import SwiftUI

struct TimerView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = TimerViewModel()
    
    var body: some View {
        let imageName = viewModel.timerActive ? "mascotAngryFace" : "mascotNormalFace"
        let imageSize = viewModel.timerActive ? CGSize(width: 161, height: 172) : CGSize(width: 159, height: 150)
        
        ZStack {
            VStack {
                HStack{
                    if(!viewModel.timerActive){
                        BackButton()
                            .padding(.leading, 12)
                    }
                    Spacer()
                    Toggle(isOn: $viewModel.isHapticsDisabled) {
                        Image(viewModel.isHapticsDisabled ? "haptic_off" : "haptic_on")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    .toggleStyle(.button)
                }
                .padding(.horizontal, 8.0)
                VStack {
                    Spacer()
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: imageSize.width, height: imageSize.height)
                        .transition(.opacity)
                }
                .animation(.easeInOut(duration: 0.3), value: viewModel.timerActive)
                .frame(height: 110)
                .padding(.bottom, 40)
                .padding(.top, 136)
                
                HStack(alignment: .bottom, spacing: 0) {
                    Text(viewModel.formattedTime)
                        .font(.custom("Pretendard-ExtraBold", size: 72))
                        .foregroundColor(viewModel.timerActive ? Theme.wrongColor : Theme.mainTextColor2)
                    Text(viewModel.formattedTimeMs)
                        .font(.custom("Pretendard-ExtraBold", size: 36))
                        .foregroundColor(viewModel.timerActive ? Theme.wrongColor : Theme.mainTextColor2)
                        .padding(.bottom, 10)
                }
                Spacer()
            }

            if !viewModel.timerActive {
                VStack {
                    Spacer()
                    WideButton(
                        buttonText: "timer_start_button_text",
                        buttonAction: { viewModel.checkPermissionsAndStartTimer(autoStart: false) },
                        disabled: false
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
