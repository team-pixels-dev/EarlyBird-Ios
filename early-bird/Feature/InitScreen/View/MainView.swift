import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            MainHeaderView(viewModel: viewModel, title: "")
            MainTopView()
            
            NavigationLink(destination: TimerView()) {
                CardViewVer(
                    buttonText: "main_start_button_text1",
                    description: "main_card_description1",
                    buttonAction: {
                        print("지금 당장 시작하기 버튼 클릭")
                    },
                    color: "tint"
                )
                .padding(.bottom, 24)
            }
            
            NavigationLink(destination: TimerView(), isActive: $viewModel.gotoTimerView) {
                EmptyView()
            }
            NavigationLink(destination: CompleteView(), isActive: $viewModel.gotoCompleteView) {
                EmptyView()
            }
            NavigationLink(destination: SettingView(), isActive: $viewModel.gotoSettingView) {
                EmptyView()
            }

            Spacer()
        }
        .applyBackground()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .navigationBarBackButtonHidden()
        .opacity(viewModel.isVisible ? 1 : 0)
        .offset(y: viewModel.isVisible ? 0 : 20)
        .animation(.easeOut(duration: 0.6), value: viewModel.isVisible)
        .onAppear {
            // lastAppState가 .timerStarted일 경우
            viewModel.handleOnAppear()
        }
    }
}
