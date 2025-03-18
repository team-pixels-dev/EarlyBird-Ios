//
//  WeekCalendarView.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/1/25.
//
import SwiftUI

struct WeekCalendarView: View {
    @Binding var currentDate: Date
    @Binding var selectedDate: Date?
    var spacingValue = 6.0
    var paddingValue = 19.0
    
    // 지난 12주, 현재 주, 다음 12주를 포함하는 예시 배열
    let weeks: [Date] = {
        let calendar = Calendar.current
        let currentWeekStart = calendar.startOfWeek(for: Date())
        return (-12...12).compactMap { offset in
            calendar.date(byAdding: .weekOfYear, value: offset, to: currentWeekStart)
        }
    }()
    

    
    var body: some View {
        VStack(spacing:0){
            Text("2025년 3월")
                .font(.system(size: 30))
                .bold()
                .padding(.leading, 23.0)
                .padding(.top, 10.0)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            GeometryReader { geometry in
                // 부모의 너비의 1/7 계산
                let squareWidth = (geometry.size.width - (spacingValue*7 + paddingValue*2)) / 7
                TabView(selection: $currentDate) {
                    ForEach(weeks, id: \.self) { weekStart in
                        HStack(spacing: spacingValue) {
                            ForEach(0..<7, id: \.self) { offset in
                                let day = Calendar.current.date(byAdding: .day, value: offset, to: weekStart)!
                                DateSquare(date: day,
                                           isSelectable: day >= Calendar.current.startOfDay(for: Date()),
                                           squareWidth: squareWidth,  // 전달
                                           selectedDate: $selectedDate)
                            }
                        }
                        .tag(weekStart) // 각 주의 시작 날짜를 태그로 설정
                    }
                }
                .padding(.horizontal, paddingValue)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .onAppear {
                    // currentDate를 현재 주의 시작 날짜로 초기화
                    currentDate = Calendar.current.startOfWeek(for: Date())
                }
            }
        }
        
    }
}
