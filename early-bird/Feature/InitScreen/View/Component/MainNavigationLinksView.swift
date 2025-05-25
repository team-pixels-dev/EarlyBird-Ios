//
//  MainNavigationLinksView.swift
//  early-bird
//
//  Created by JAYOU KOO on 5/23/25.
//
import SwiftUI

struct MainNavigationLinksView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        Group {
            NavigationLink(destination: ScheduleView(), isActive: $viewModel.gotoScheduleView){
                EmptyView() }
            NavigationLink(destination: TimerView(), isActive: $viewModel.gotoTimerView) { EmptyView() }
            NavigationLink(destination: CompleteView(), isActive: $viewModel.gotoCompleteView) { EmptyView() }
            NavigationLink(destination: SettingView(), isActive: $viewModel.gotoSettingView) { EmptyView() }
        }
    }
}
