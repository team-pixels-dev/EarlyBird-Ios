import SwiftUI

struct ShadowedRoundedImageView: View {
    var body: some View {
        ZStack {
            // 그림자 2중 효과
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.0001)) // 배경 필요 없음, 그림자만 보여주기 위함
                .frame(width: 263, height: 198)
                .shadow(color: Color(red: 0.216, green: 0.792, blue: 0.941, opacity: 1), radius: 2, x: 0, y: 0)
                .shadow(color: Color(red: 0.216, green: 0.792, blue: 0.941, opacity: 1), radius: 10, x: 0, y: 0)

            // 이미지와 클립 처리
            Image("IMG_0487")
                .resizable()
                .scaledToFill()
                .frame(width: 263, height: 198)
                .clipShape(RoundedRectangle(cornerRadius: 20))

            // 파란색 테두리
            RoundedRectangle(cornerRadius: 23)
                .stroke(Color(red: 0.211, green: 0.794, blue: 0.94), lineWidth: 3)
                .frame(width: 269, height: 204) // 263 + (3*2) inset 보정
        }
        .frame(width: 269, height: 204) // 전체 View 크기 = stroke 기준
        .padding(.top, 405) // UIKit의 topAnchor와 유사하게 적용
    }
}
