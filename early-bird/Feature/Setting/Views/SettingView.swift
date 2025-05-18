import SwiftUI

struct SettingView: View {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var viewModel = SettingViewModel()
    @State private var showPrivacySettings = false

    var body: some View {
        VStack(spacing: 0) {
            SettingHeaderView(title: "설정")
            
            ScrollView{
                VStack(spacing: 0) {
                    FeedbackItemView(viewModel: viewModel)
                    
                    ForEach(viewModel.sections, id: \.title) { section in
                        SettingSectionView(section: section, viewModel: viewModel)
                    }
                }
            }
            
            NavigationLink(destination: PrivacySettingView(), isActive: $viewModel.gotoPrivacyPolicy) {
                EmptyView()
            }
        }
        .applyBackground()
        .navigationBarBackButtonHidden()
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                // 앱이 포어그라운드로 전환될 때 실행될 코드 - 알림권한 여부 업데이트
                viewModel.onForeground()
            }
        }
        .modal(isPresented: $viewModel.showTextFeedbackModal) {
            TextFeedbackModal(showModal: $viewModel.showTextFeedbackModal)
        }
    }
}

#Preview {
    SettingView()
}
