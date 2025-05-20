import SwiftUI

struct MainHeaderView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        HStack {
            Spacer()
            
            Button(action: {
                viewModel.gotoSettingView = true
            }) {
                Image("settingIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 26, height: 26)
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 30.0)
    }
} 
