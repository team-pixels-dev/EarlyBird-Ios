import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        ZStack {
            Image("mainPageBg")
                .resizable()
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack(spacing: 0) {
                MainHeaderView(viewModel: viewModel)
                MainTopSectionView(viewModel: viewModel)
                Spacer()
                MainMascotView()
                MainBottomActionView(onStartTapped: viewModel.onStartRightNowTapped)
                MainNavigationLinksView(viewModel: viewModel)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarBackButtonHidden()
            .opacity(viewModel.isVisible ? 1 : 0)
            .offset(y: viewModel.isVisible ? 0 : 20)
            .animation(.easeOut(duration: 0.6), value: viewModel.isVisible)
            .onAppear {
                viewModel.handleOnAppear()
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    MainView()
}
