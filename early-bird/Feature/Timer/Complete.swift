//
//  complete.swift
//  early-bird
//
//  Created by JAYOU KOO on 2/24/25.
//

import SwiftUI

struct CompleteView: View {
    @State var showNextView: Bool = false
    @State private var showNPSModal = false
    @State private var showTextFeedbackModal = false
    @EnvironmentObject var appStateManager: AppStateManager
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("얼리버드와 함께라면\n혼자선 어려운 일도\n쉽게 시작할 수 있어요!")
                    .font(.custom("Pretendard-SemiBold", size: 28))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Theme.mainTextColor2)
                Spacer()
                WideButton(buttonText: "완료", buttonAction: {complete()}, disabled: false)
                
                NavigationLink(destination: MainView(), isActive: $showNextView) {
                    EmptyView()
                }
            }
            .applyBackground()
            .modal(isPresented: $showNPSModal) {
                NPSModal(showModal: $showNPSModal)
            }
            .modal(isPresented: $showTextFeedbackModal) {
                TextFeedbackModal(showModal: $showTextFeedbackModal)
            }
            .onChange(of: showNPSModal) { newValue in
                if !newValue { // showNPSModal이 false가 될 때
                    showTextFeedbackModal = true
                }
            }
            .onChange(of: showTextFeedbackModal) { newValue in
                if !newValue {
                    appStateManager.lastAppState = .home
                    showNextView = true
                }
            }
            .onAppear {
                appStateManager.lastAppState = .completed
                HapticFeedbackManager.triggerHapticFeedbackPattern()
                AppLimiter.shared.stopBlocking()
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    func complete() {
        var tracker = AttendanceTracker()
        let attendanceCount = tracker.markAttendance()
        if (attendanceCount == 1 || attendanceCount == 3 || attendanceCount == 7){
            showNPSModal = true
        } else {
            appStateManager.lastAppState = .home
            showNextView = true
        }
    }
    
}

struct CompleteView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteView()
    }
}
