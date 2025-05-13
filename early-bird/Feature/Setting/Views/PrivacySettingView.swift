import SwiftUI

struct PrivacySettingView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = SettingViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // 헤더
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color(red: 0.30, green: 0.30, blue: 0.30))
                            .font(.system(size: 18, weight: .medium))
                    }
                    
                    Spacer()
                    
                    Text("개인정보 처리방침 설정")
                        .foregroundColor(Color(red: 0.30, green: 0.30, blue: 0.30))
                        .font(.custom("PretendardVariable-Regular", size: 18))
                    
                    Spacer()
                    
                    // 오른쪽 정렬을 위한 빈 공간
                    Color.clear
                        .frame(width: 18, height: 18)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.white)
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color(red: 0.90, green: 0.90, blue: 0.90)),
                    alignment: .bottom
                )
                
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
