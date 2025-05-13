//
//  BackButton.swift
//  early-bird
//
//  Created by JAYOU KOO on 5/13/25.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button(action: { dismiss() }) {
            Image(systemName: "chevron.left")
                .foregroundColor(Color(red: 0.30, green: 0.30, blue: 0.30))
                .font(.system(size: 18, weight: .medium))
        }
    }
}
