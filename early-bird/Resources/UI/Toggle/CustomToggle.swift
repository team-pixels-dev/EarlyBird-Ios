//
//  SettingToggle.swift
//  early-bird
//
//  Created by JAYOU KOO on 5/25/25.
//


import SwiftUI

/// Optional<Bool> 바인딩을 내부 Bool 바인딩으로 변환하고, 토글 실행 시 onToggle만 호출하는 커스텀 토글
struct CustomToggle: View {
    @Binding var isEnabled: Bool?
    let onToggle: (() -> Void)?
    let tintColor: Color = Theme.secondaryColor

    var body: some View {
        Toggle("", isOn: Binding<Bool>(
            get: { isEnabled ?? false },
            set: { _ in onToggle?() }
        ))
        .labelsHidden()
        .tint(tintColor)
    }
}
