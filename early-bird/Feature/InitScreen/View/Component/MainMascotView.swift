//
//  MainMascotView.swift
//  early-bird
//
//  Created by JAYOU KOO on 5/23/25.
//
import SwiftUI

struct MainMascotView: View {
    var body: some View {
        HStack {
            Image("mainPageMascot")
                .resizable()
                .scaledToFit()
                .frame(height: 235)
                .padding(.leading, 20)
            Spacer()
        }
        .padding(.bottom, 20)
    }
}
