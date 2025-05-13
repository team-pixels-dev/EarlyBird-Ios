import SwiftUI

struct SettingView: View {
    @StateObject private var viewModel = SettingViewModel()
    @State private var showPrivacySettings = false

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                SettingHeaderView(title: "설정")
                
                FeedbackItemView()
                
                ForEach(viewModel.sections, id: \.title) { section in
                    SettingSectionView(section: section, viewModel: viewModel)
                }
            }

            NavigationLink(destination: PrivacySettingView(), isActive: $viewModel.gotoPrivacyPolicy) {
                EmptyView()
            }
        }
        .applyBackground()
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    SettingView()
}
