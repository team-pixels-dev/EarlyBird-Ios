import SwiftUI

struct PrivacySettingView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = SettingViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // 헤더
                SettingHeaderView(title: "개인정보처리방침 설정")
                
                // 섹션들
                ForEach(SettingModel.shared.privacySections, id: \.title) { section in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(section.title)
                            .foregroundColor(Color(red: 0.70, green: 0.70, blue: 0.70))
                            .font(.custom("PretendardVariable-Regular", size: 14))
                            .padding(.horizontal, 16)
                            .padding(.top, 24)
                            .padding(.bottom, 8)
                        
                        VStack(spacing: 0) {
                            ForEach(section.items, id: \.title) { item in
                                SettingItemView(
                                    item: item,
                                    isToggleEnabled: getToggleBinding(for: item),
                                    onToggle: getToggleAction(for: item),
                                    onClick: getClickAction(for: item)
                                )
                                
                                if item != section.items.last {
                                    Divider()
                                        .padding(.leading, 16)
                                }
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal, 16)
                    }
                }
            }
        }
        .navigationBarHidden(true)
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
