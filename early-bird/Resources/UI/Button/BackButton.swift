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
            Image("backBtn")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 13, height: 22)
        }
    }
}
