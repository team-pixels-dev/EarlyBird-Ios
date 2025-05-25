//
//  ScheduleView.swift
//  early-bird
//
//  Created by JAYOU KOO on 5/25/25.
//

import SwiftUI

struct ScheduleView: View {
    @State private var selectedHour = 12
    @State private var selectedMinute = 5
    @State private var selectedPeriod = 1 // 0 for AM, 1 for PM
    @State private var isVibrateEnabled = true
    @State private var selectedRepeatOption = 0 // 0 for 반복 알람, 1 for 한 번 알람
    
    let hours = Array(1...12)
    let minutes = Array(0...59)
    let periods = ["AM", "PM"]
    
    var body: some View {
        VStack{
            HeaderView(title: "")
            
            Image("mascotSchedule1")
                .resizable()
                .scaledToFit()
                .frame(height: 75)
            
            VStack(alignment: .leading){
                HStack(spacing: 0) {
                    Spacer()
                    
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
                    
                    Spacer()
                }
                .padding(.horizontal, 60)
            }
            .background(Theme.appBackgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Spacer()
            
        }
        .applyBackground()
    }
}

#Preview {
    ScheduleView()
}
