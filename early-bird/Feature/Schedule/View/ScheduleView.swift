//
//  ScheduleView.swift
//  early-bird
//
//  Created by JAYOU KOO on 5/25/25.
//

import SwiftUI

struct ScheduleView: View {
    @State private var imageName: String = "mascotSchedule1"
    @State private var offsetX: CGFloat = -UIScreen.main.bounds.width
    
    @State private var selectedHour: Int
    @State private var selectedMinute: Int
    @State private var selectedPeriod = 1 // 0 for AM, 1 for PM
    @State private var selectedRepeatOption = 0 // 0 for 반복 알람, 1 for 한 번 알람
    @State private var isVibrationEnabled: Bool? = true
    @State private var titleText: String = ""
    
    @FocusState var focusedField: Field?
    
    init() {
        let now = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: now)      // 0~23
        let minute = calendar.component(.minute, from: now)  // 0~59
        
        selectedHour = hour % 12 // 0~12
        selectedMinute = minute  // 0~59
        selectedPeriod = hour < 12 ? 1 : 0
    }
    
    let hours = Array(1...12)
    let minutes = Array(0...59)
    let periods = ["AM", "PM"]
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing:0){
                HeaderView(title: "")
                    .id("header") // ScrollView 앵커 포인트
                
                Image(imageName)
                  .resizable()
                  .scaledToFit()
                  .frame(height: 75)
                  .offset(x: offsetX)
                
                
                VStack(spacing: 20){
                    VStack{
                        Button(action:{focusedField = .mainInput}){
                            ScheduleTitleTextInput(text: $titleText, placeholder: "밀린 과제 시작하기")
                                .focused($focusedField, equals: .mainInput)
                                .padding(.top, 24)
                        }
                        HStack(spacing: 0) {
                            // 시간 (Hour) 휠
                            CustomWheelPicker(
                                selection: $selectedHour,
                                items: hours,
                                displayFormat: { String(format: "%02d", $0) }
                            )
                            
                            // 분 (Minute) 휠
                            CustomWheelPicker(
                                selection: $selectedMinute,
                                items: minutes,
                                displayFormat: { String(format: "%02d", $0) }
                            )
                            
                            // AM/PM 휠
                            CustomWheelPicker(
                                selection: $selectedPeriod,
                                items: Array(0..<periods.count),
                                displayFormat: { periods[$0] }
                            )
                        }
                        .padding(.horizontal, 50)
                        .padding(.top, 10)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 256)
                    .background(Theme.backgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    
                    VStack(alignment: .leading, spacing: 12){
                        FontText(text: "반복 알람", weight: .bold, size: 16, alignment: .center)
                            .foregroundStyle(Theme.mainTextColor2)
                            .padding(.top, 16)
                        RadioButtonGroup()
                            .frame(maxWidth: .infinity)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 142, alignment: .leading)
                    .padding(.horizontal, 20)
                    .background(Theme.backgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    HStack {
                        FontText(text: "진동", weight: .bold, size: 16)
                            .foregroundStyle(Theme.mainTextColor2)
                        Spacer()
                        CustomToggle(
                            isEnabled: $isVibrationEnabled,
                            onToggle: {
                                isVibrationEnabled?.toggle()
                            }
                        )
                    }
                    .frame(maxWidth: .infinity, maxHeight: 62)
                    .padding(.horizontal, 20)
                    .background(Theme.backgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.horizontal, 16)
                
                RoundedButton(buttonText: "완료", buttonAction: {}, type: .small, disabled: false, shadow: false)
                    .padding(.top, 31)
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            // 1) 1초 동안 왼쪽에서 중앙으로 이동
            withAnimation(.easeOut(duration: 1.5)) {
                offsetX = 0
            }
            
            // 2) 1초 이동 완료 + 0.5초 후에 이미지 교체 및 햅틱
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                withAnimation(.easeIn(duration: 0.1)) {
                    imageName = "mascotSchedule2"
                }
                // 햅틱 피드백
                HapticFeedbackManager.mediumImpact()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    focusedField = .mainInput
                }
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    ScheduleView()
}
