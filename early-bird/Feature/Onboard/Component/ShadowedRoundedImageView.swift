//
//  ShadowedRoundedImageView.swift
//  early-bird
//
//  Created by JAYOU KOO on 4/15/25.
//


import SwiftUI

struct ShadowedRoundedImageView: View {
    @State private var isBlinking = false
    @State private var handYOffset: CGFloat = 105;
    
    var body: some View {
        ZStack {
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white.opacity(1))
                    .frame(width: 263*1.02, height: 198*1.02)
                    .shadow(color: Color(red: 0.216, green: 0.792, blue: 0.941, opacity: 1), radius: 2, x: 0, y: 0)
                    .shadow(color: Color(red: 0.216, green: 0.792, blue: 0.941, opacity: 1), radius: 10, x: 0, y: 0)
                
                RoundedRectangle(cornerRadius: 23)
                    .stroke(Color(red: 0.211, green: 0.794, blue: 0.94), lineWidth: 3)
                    .frame(width: 263*1.02, height: 198*1.02)
            }
            .opacity(isBlinking ? 0.1 : 1) // ✨ 깜빡임 효과
            .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: isBlinking)
            

            // 이미지와 클립 처리
            Image("screenTimeAccess")
                .resizable()
                .frame(width: 263, height: 198)
            
            Image("hand")
                .resizable()
                .scaledToFill()
                .frame(width: 36, height: 40)
                .offset(x: -70, y: handYOffset)
                .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: handYOffset)
            
        }
        .frame(height: 240.0)
        .onAppear {
            isBlinking = true
            handYOffset = 110
        }
    }
}

struct ShadowedRoundedImageViewWithotEffect: View {
    @State private var isBlinking = false
    @State private var handYOffset: CGFloat = 105;
    
    var body: some View {
        ZStack {
            Image("screenTimeAccess")
                .resizable()
                .frame(width: 263, height: 198)
        }
        .frame(height: 240.0)
    }
}
