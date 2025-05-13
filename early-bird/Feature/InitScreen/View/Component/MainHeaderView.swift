import SwiftUI

struct MainHeaderView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: MainViewModel
    let title: LocalizedStringKey
    
    var body: some View {
        HStack {
            Spacer()
            
            Text(title)
                .foregroundColor(Color(red: 0.30, green: 0.30, blue: 0.30))
                .font(.custom("PretendardVariable-Regular", size: 18))
            
            Spacer()
            
            Button(action: {
                viewModel.gotoSettingView = true
            }) {
                Image("settingIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 30.0)
    }
} 
