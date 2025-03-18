//
//  ModalExtension.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/18/25.
//
import SwiftUI

extension View {
    @ViewBuilder
    func modal<ModalContent: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> ModalContent
    ) -> some View {
        ZStack {
            self
            if isPresented.wrappedValue {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isPresented.wrappedValue = false
                    }
                content() // ✅ 클로저 형태로 전달
            }
        }
    }
}

