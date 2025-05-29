//
//  ScheduleView.swift
//  early-bird
//
//  Created by JAYOU KOO on 5/25/25.
//

import SwiftUI

struct ScheduleView: View {
    @StateObject private var viewModel = ScheduleViewModel()
    @FocusState private var focusedField: Field?
    
    private let hours = Array(1...12)
    private let minutes = Array(0...59)
    private let periods = ["AM", "PM"]
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                HeaderView(title: "")
                    .id("header")

                Image(viewModel.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 75)

                VStack(spacing: 20) {
                    // Title & Time picker
                    VStack {
                        Button(action: { focusedField = .mainInput }) {
                            ScheduleTitleTextInput(text: $viewModel.titleText,
                                                   placeholder: "밀린 과제 시작하기")
                                .focused($focusedField, equals: .mainInput)
                                .padding(.top, 24)
                        }
                        HStack(spacing: 0) {
                            CustomWheelPicker(selection: $viewModel.selectedHour,
                                              items: hours,
                                              displayFormat: { String(format: "%02d", $0) })
                            CustomWheelPicker(selection: $viewModel.selectedMinute,
                                              items: minutes,
                                              displayFormat: { String(format: "%02d", $0) })
                            CustomWheelPicker(selection: $viewModel.selectedPeriod,
                                              items: Array(0..<periods.count),
                                              displayFormat: { periods[$0] })
                        }
                        .padding(.horizontal, 50)
                        .padding(.top, 10)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 256)
                    .background(Theme.backgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                    // Repeat option
                    VStack(alignment: .leading, spacing: 12) {
                        FontText(text: "반복 알람", weight: .bold, size: 16)
                            .foregroundStyle(Theme.mainTextColor2)
                            .padding(.top, 16)
                        RadioButtonGroup(selection: $viewModel.selectedRepeatOption)
                            .frame(maxWidth: .infinity)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 142)
                    .padding(.horizontal, 20)
                    .background(Theme.backgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    // Vibration toggle
                    HStack {
                        FontText(text: "진동", weight: .bold, size: 16)
                            .foregroundStyle(Theme.mainTextColor2)
                        Spacer()
                        CustomToggle(isEnabled: $viewModel.isVibrationEnabled,
                                     onToggle: viewModel.toggleVibration)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 62)
                    .padding(.horizontal, 20)
                    .background(Theme.backgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.horizontal, 16)

                RoundedButton(buttonText: "완료",
                              buttonAction: {},
                              type: .small,
                              disabled: false,
                              shadow: false)
                    .padding(.top, 31)

                Spacer()
            }
            .onAppear {
                viewModel.onAppear()
                focusedField = viewModel.focusedField
            }
        }
        .applyBackground()
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    ScheduleView()
}
