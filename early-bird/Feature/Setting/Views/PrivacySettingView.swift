import SwiftUI

struct PrivacySettingView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = SettingViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            SettingHeaderView(title: "개인정보처리방침 설정")
            
            ScrollView{
                ForEach(viewModel.privacySections, id: \.title) { section in
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
    
    private func getToggleBinding(for item: SettingItem) -> Binding<Bool?> {
        switch item.type {
        case .dataCollection:
            return Binding(
                get: { viewModel.isDataCollectionEnabled },
                set: { _ in viewModel.toggleDataCollection() }
            )
        default:
            return .constant(nil)
        }
    }
    
    private func getToggleAction(for item: SettingItem) -> (() -> Void)? {
        switch item.type {
        case .dataCollection:
            return viewModel.toggleDataCollection
        case .privacyPolicy:
            return viewModel.openPrivacyPolicy
        default:
            return nil
        }
    }
    
    private func getClickAction(for item: SettingItem) -> (() -> Void)? {
        switch item.type {
        case .dataCollection:
            return viewModel.toggleDataCollection
        case .privacyPolicy:
            return viewModel.openPrivacyPolicy
        default:
            return nil
        }
    }
}

#Preview {
    PrivacySettingView()
}
