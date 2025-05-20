import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        ZStack{
            Image("mainPageBg")
                .resizable()
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack(spacing: 0) {
                MainHeaderView(viewModel: viewModel)
                
                ZStack{
                    Image("mainPageTop")
                        .resizable()
                        .scaledToFit()
                        .frame(height:95)
                    
                    VStack(alignment: .leading){
                        Spacer()
                        FontText(text: LocalizedStringKey(formatDateText(Date())), weight: .bold, size: 16, alignment: .center)
                            .foregroundStyle(Theme.mainTextColor2)
                            .padding(.bottom, 10)
                            .padding(.leading, 70)
                        HStack{
                            HStack{
                                FontText(text: "나는", weight: .bold, size: 16, alignment: .center)
                                    .foregroundStyle(Theme.brightTextColor)
                                FontText(text: LocalizedStringKey( viewModel.resolutionText), weight: .bold, size: 16, alignment: .center)
                                    .foregroundStyle(Theme.brightTextColor)
                                if isLanguageKorean() {
                                    FontText(text: "사람이 될거야!", weight: .bold, size: 16, alignment: .center)
                                        .foregroundStyle(Theme.brightTextColor)
                                }
                            }
                            .frame(width: 297)
                            .padding(.bottom, 12)
                        }
                        .padding(.bottom, 12)
                        .padding(.leading, 56)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: 95, alignment: .leading)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: 95)
                .padding(.top, 15)
                
                Spacer()
                
                HStack{
                    Image("mainPageMascot")
                        .resizable()
                        .scaledToFit()
                        .frame(height:235)
                        .padding(.leading, 20)
                    Spacer()
                }
                .padding(.bottom, 20)
                
                VStack{
                    FontText(text: "얼리버드와 함께 해요!", weight: .bold, size: 22, alignment: .center)
                        .foregroundStyle(Theme.mainTextColor2)
                        .padding(.top, 45)
                        .padding(.bottom, 20)
                    NavigationLink(destination: TimerView()) {
                        Image("mainPageButton")
                            .resizable()
                            .scaledToFit()
                            .frame(height:137)
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: 317)
                .background(
                    Theme.backgroundColor
                            .clipShape(RoundedCorner(radius: 30, corners: [.topLeft, .topRight]))
                    )
                .ignoresSafeArea()
                
                
                NavigationLink(destination: TimerView(), isActive: $viewModel.gotoTimerView) {
                    EmptyView()
                }
                NavigationLink(destination: CompleteView(), isActive: $viewModel.gotoCompleteView) {
                    EmptyView()
                }
                NavigationLink(destination: SettingView(), isActive: $viewModel.gotoSettingView) {
                    EmptyView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .navigationBarBackButtonHidden()
            .opacity(viewModel.isVisible ? 1 : 0)
            .offset(y: viewModel.isVisible ? 0 : 20)
            .animation(.easeOut(duration: 0.6), value: viewModel.isVisible)
            .onAppear {
                // lastAppState가 .timerStarted일 경우
                viewModel.handleOnAppear()
            }
            .ignoresSafeArea(edges: .bottom)
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

#Preview {
    MainView()
}
