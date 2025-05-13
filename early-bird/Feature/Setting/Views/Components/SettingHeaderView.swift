import SwiftUI

struct SettingHeaderView: View {
    @Environment(\.dismiss) private var dismiss
    let title: LocalizedStringKey
    
    var body: some View {
        HStack {
            BackButton()
            
            Spacer()
            
            Text(title)
                .foregroundColor(Color(red: 0.30, green: 0.30, blue: 0.30))
                .font(.custom("PretendardVariable-Regular", size: 18))
            
            Spacer()
            
            // 오른쪽 정렬을 위한 빈 공간
//            Color.clear
//                .frame(width: 18, height: 18)
            
            Image("xBtn")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 15, height: 15)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 16)
        .background(Color.white)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(red: 0.90, green: 0.90, blue: 0.90)),
            alignment: .bottom
        )
    }
} 
