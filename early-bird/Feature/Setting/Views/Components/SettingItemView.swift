import SwiftUI

struct SettingItemView: View {
    let item: SettingItem
    let isToggleEnabled: Binding<Bool?>
    let onToggle: (() -> Void)?
    let onClick: (() -> Void)?
    
    var body: some View {
        Button(action: {
            onClick?()
        }) {
            SettingItemContent(
                item: item,
                isToggleEnabled: isToggleEnabled,
                onToggle: onToggle
            )
        }
    }
}

private struct SettingItemContent: View {
    let item: SettingItem
    let isToggleEnabled: Binding<Bool?>
    let onToggle: (() -> Void)?
    
    var body: some View {
        HStack {
            itemText
            Spacer()
            trailingView
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
    
    private var itemText: some View {
        VStack(alignment: .leading, spacing: 4) {
            FontText(text: LocalizedStringKey(item.title), weight: .regular, size: 16, alignment: .leading)
                .foregroundColor(Theme.mainTextColor2)
            
            if !item.description.isEmpty {
                FontText(text: LocalizedStringKey(item.description), weight: .regular, size: 14, alignment: .leading)
                    .foregroundColor(Theme.grayColor)
            }
        }
    }
    
    private var trailingView: some View {
        Group {
            if isToggleEnabled.wrappedValue != nil {
                Toggle("", isOn: Binding(
                    get: { isToggleEnabled.wrappedValue ?? false },
                    set: { _ in onToggle?() }
                ))
                .labelsHidden()
                .tint(Theme.secondaryColor)
            } else {
                Image(systemName: "chevron.right")
                    .foregroundColor(Color(red: 0.70, green: 0.70, blue: 0.70))
                    .font(.system(size: 14, weight: .medium))
            }
        }
    }
} 
