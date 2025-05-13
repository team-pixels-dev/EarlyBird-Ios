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
            Text(item.title)
                .foregroundColor(Color(red: 0.30, green: 0.30, blue: 0.30))
                .font(.custom("PretendardVariable-Regular", size: 16))
            
            if !item.description.isEmpty {
                Text(item.description)
                    .foregroundColor(Color(red: 0.70, green: 0.70, blue: 0.70))
                    .font(.custom("PretendardVariable-Regular", size: 14))
                    .multilineTextAlignment(.leading)
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
                .tint(Color(red: 0.00, green: 0.48, blue: 1.00))
            } else {
                Image(systemName: "chevron.right")
                    .foregroundColor(Color(red: 0.70, green: 0.70, blue: 0.70))
                    .font(.system(size: 14, weight: .medium))
            }
        }
    }
} 
