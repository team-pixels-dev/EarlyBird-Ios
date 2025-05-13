import SwiftUI

struct SettingSectionView: View {
    let section: SettingSection
    @ObservedObject var viewModel: SettingViewModel
    
    var body: some View {
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
                        onClick: getToggleAction(for: item)
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
    
    private func getToggleBinding(for item: SettingItem) -> Binding<Bool?> {
        switch item.type {
        case .notification:
            return Binding(
                get: { viewModel.isNotificationEnabled },
                set: { _ in viewModel.toggleNotification() }
            )
        case .timeNotification:
            return Binding(
                get: { viewModel.isTimeNotificationEnabled },
                set: { _ in viewModel.toggleTimeNotification() }
            )
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
        case .notification:
            return viewModel.toggleNotification
        case .timeNotification:
            return viewModel.toggleTimeNotification
        case .dataCollection:
            return viewModel.toggleDataCollection
        case .feedback:
            return viewModel.openFeedback
        case .terms:
            return viewModel.openTerms
        case .privacy:
            return viewModel.openPrivacy
        case .privacyPolicy:
            return viewModel.openPrivacyPolicy
        }
    }
    
    private func getClickAction(for item: SettingItem) -> (() -> Void)? {
        switch item.type {
        case .notification:
            return viewModel.toggleNotification
        case .timeNotification:
            return viewModel.toggleTimeNotification
        case .dataCollection:
            return viewModel.toggleDataCollection
        case .feedback:
            return viewModel.openFeedback
        case .terms:
            return viewModel.openTerms
        case .privacy:
            return viewModel.openPrivacy
        case .privacyPolicy:
            return viewModel.openPrivacyPolicy
        }
    }
}
