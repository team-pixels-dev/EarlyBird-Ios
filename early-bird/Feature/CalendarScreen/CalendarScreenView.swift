//
//  CalenderScreenView.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/1/25.
//
import SwiftUI

struct CalendarScreenView: View {
    @State private var currentDate = Date() // 현재 날짜
    @State private var selectedDate: Date? = Date() // 선택된 날짜
    @State private var schedules: [String: [String]] = [:] // 일정 데이터 (예시)

    var body: some View {
        VStack {
            // 주간 캘린더 뷰
            WeekCalendarView(currentDate: $currentDate, selectedDate: $selectedDate)
                .frame(height: 140)

            // 선택된 날짜의 일정 표시
            if let selectedDate = selectedDate {
                let weekStart = Calendar.current.startOfWeek(for: selectedDate)
                let weekEnd = Calendar.current.endOfWeek(for: selectedDate)
                let weekKey = "\(weekStart.formatted()) - \(weekEnd.formatted())"

                if let weekSchedules = schedules[weekKey] {
                    List(weekSchedules, id: \.self) { schedule in
                        Text(schedule)
                    }
                } else {
                    Text("No schedules for this week")
                        .foregroundColor(.gray)
                }
            } else {
                Text("Select a date to view schedules")
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .onAppear {
            // 예시 데이터 로드
            loadSampleSchedules()
        }
        .navigationBarBackButtonHidden(true)
    }

    // 예시 일정 데이터 로드
    private func loadSampleSchedules() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        let week1Start = formatter.date(from: "2023-10-23")!
        let week1End = formatter.date(from: "2023-10-29")!
        schedules["\(week1Start.formatted()) - \(week1End.formatted())"] = [
            "Meeting with team",
            "Lunch with friends",
            "Gym session"
        ]

        let week2Start = formatter.date(from: "2023-10-30")!
        let week2End = formatter.date(from: "2023-11-05")!
        schedules["\(week2Start.formatted()) - \(week2End.formatted())"] = [
            "Project deadline",
            "Doctor's appointment"
        ]
    }
}

#Preview {
    CalendarScreenView()
}

