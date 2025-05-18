import SwiftUI

struct MainHeaderView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: MainViewModel
    let title: LocalizedStringKey
    
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
