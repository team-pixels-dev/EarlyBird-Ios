//
//  DateSquare.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/4/25.
//

import SwiftUI

// 날짜를 표시하는 정사각형 컴포넌트
struct DateSquare: View {
    let date: Date
    let isSelectable: Bool
    let squareWidth: CGFloat
    @Binding var selectedDate: Date?
    
    var body: some View {
        let isSelected = selectedDate.map { Calendar.current.isDate($0, inSameDayAs: date) } ?? false
        let dayText = date.formatted(.dateTime.weekday(.abbreviated))
        
        Button(action: {
            if isSelectable {
                selectedDate = date
            }
        }) {
            VStack(spacing: -2) {
                Text(dayText)
                    .font(.system(size: 12))
                    .foregroundStyle(isSelected ? .black : (isSelectable ? .black: .gray))
                Text("\(Calendar.current.component(.day, from: date))")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(isSelected ? .white : (isSelectable ? Theme.grayTextColor: .gray))
            }
            .frame(width: squareWidth, height: 47)
            .background(isSelected ? Theme.primaryColor : (isSelectable ? Theme.grayColor : Color.gray.opacity(0.1)))
            .cornerRadius(8)
        }
        .disabled(!isSelectable)
    }
}
