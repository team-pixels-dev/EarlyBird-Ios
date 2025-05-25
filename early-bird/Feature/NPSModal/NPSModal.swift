//
//  RatingView.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/17/25.
//
import SwiftUI

struct NPSModal: View {
    @State private var selectedRating: Int = -1 // 선택된 평점
    @Binding var showModal: Bool

    // 한 행에 4개씩 배치되도록 GridItem 설정
    let columns = Array(repeating: GridItem(.fixed(48), spacing: 12), count: 4)

    var body: some View {
        VStack(alignment: .leading) {
            Text("얼리버드를 주변에 얼마나\n추천하고 싶으신가요?")
                .font(.custom("Pretendard-SemiBold", size: 16))
                .foregroundStyle(Theme.mainTextColor2)
                .font(.headline)
                .multilineTextAlignment(.leading)
                .padding(.top, 20)
                .padding(.leading, 20)

            HStack {
                Text("추천 안해요")
                    .font(.custom("Pretendard-Medium", size: 12))
                    .foregroundStyle(.gray)
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 5)

            VStack(spacing: 0) {
                // 첫 8개의 버튼 (그리드 형태)
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(0..<8, id: \.self) { rating in
                        ratingButton(rating)
                    }
                }
                .padding(.bottom, 12)
                // 마지막 줄 (3개) 중앙 정렬
                HStack(spacing: 12) {
                    Spacer()
                    ForEach(8..<11, id: \.self) { rating in
                        ratingButton(rating)
                    }
                    Spacer()
                }
            }
            
            HStack {
                Spacer()
                Text("정말 추천 해요")
                    .font(.custom("Pretendard-Medium", size: 12))
                    .foregroundStyle(.gray)
            }
            .padding(.horizontal, 20)
            Spacer()
        
            // 제출 버튼
            Button(action: {
                sendRating(rating: selectedRating)
                showModal = false
                print("제출")
            }) {
                Text("submit")
                    .font(.headline)
                    .frame(maxWidth: .infinity, minHeight: 54)
                    .background(selectedRating != -1 ? Theme.primaryColor : Theme.disabledColor)
                    .foregroundStyle(.white)
            }.disabled(selectedRating == -1)
        }
        .frame(width: 270, height: 380)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
    }
    
    func ratingButton(_ rating: Int) -> some View {
        Button(action: {
            selectedRating = rating
        }) {
            Text("\(rating)")
                .font(.custom("Pretendard-SemiBold", size: 16))
                .fontWeight(.bold)
                .frame(width: 48, height: 48) // 버튼 크기 고정
                .background(selectedRating == rating ? Theme.primaryColor : Theme.notSelectedColor)
                .foregroundStyle(selectedRating == rating ? Theme.brightTextColor : Theme.mainTextColor)
                .clipShape(Circle())
        }
        .padding(0) // 내부 여백 제거
    }
    
    func sendRating(rating: Int){
        if(rating == -1) {
            return
        }
        
        let NPSData = NPSJson(
            score: rating,
            clientId: ClientIDManager.getClientID(),
            createdAt: formatDate(Date()),
            dayCount: 1
        )
        
        sendPostRequest(to: "/api/v1/feedbacks/scores", with: NPSData){_ in }
    }
}

struct NPSJson :Codable {
    let score: Int
    let clientId: String
    let createdAt: String
    let dayCount: Int
}

struct RatingView_Previews: PreviewProvider {
    @State static var showModal: Bool = true
    static let previewInstance = NPSModal(showModal: $showModal)

    static var previews: some View {
        previewInstance
    }
}
