import SwiftUI

struct HeaderView: View {
    @Environment(\.dismiss) private var dismiss
    let title: LocalizedStringKey
    
    var body: some View {
        ZStack{
            HStack {
                BackButton()
                
                Spacer()
                
//                Image("xBtn")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 21, height: 28)
            }
            .padding(.horizontal, 20)
            .padding(.top, 6)
            .padding(.bottom, 16)
            .background(Theme.backgroundColor)
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color(red: 0.90, green: 0.90, blue: 0.90)),
                alignment: .bottom
            )
            
            HStack {
                Spacer()
                
                FontText(text: title, weight: .regular, size: 18, alignment: .center)
                    .foregroundColor(Theme.mainTextColor2)
                
                Spacer()
            }
            .padding(.top, 6)
            .padding(.bottom, 16)
        }
    }
} 
