//
//  HomeView.swift
//  early-bird
//
//  Created by JAYOU KOO on 3/9/25.
//

import SwiftUI
import FamilyControls

struct Home: View {
    @EnvironmentObject var familyViewModel: FamilyViewModel
    @State var showPicker = false
    
    var body: some View {
        VStack{
            Text("선택 된 앱 개수 \(familyViewModel.appSelection.applicationTokens.count)")
            Text("선택 된 카테고리 개수 \(familyViewModel.appSelection.categoryTokens.count)")
            
            if (familyViewModel.appSelection.applicationTokens.count == 0) {
                Spacer()
                Text("선택 된 앱이 없습니다")
                Spacer()
            } else {
                List{
                    ForEach(Array(familyViewModel.appSelection.applicationTokens), id: \.self) { applicationToken in
                        ZStack (alignment: Alignment(horizontal: .leading, vertical: .center)){
                            HStack{
                                Label(applicationToken)
                                    .scaleEffect(CGSize(width: 0.95, height: 0.95))
                                Spacer()
                            }
                            Label(applicationToken)
                                .labelStyle(.iconOnly)
                                .scaleEffect(CGSize(width: 1.6, height: 1.6))
                        }
                        .frame(height: 50)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                    }
                }
                 .listStyle(.plain)
                 .listStyle(.grouped)
            }
            
            // FamilyActivityPicker(selection: $familyViewModel.appSelection)
            
            Button (action: {
                showPicker = true
            }) {
                Text("앱 선택하기")
            }.familyActivityPicker(isPresented: $showPicker, selection: $familyViewModel.appSelection)
        }
    }
}

#Preview {
    @Previewable @StateObject var familyViewModel = FamilyViewModel()
    return Home().environmentObject(familyViewModel)
}
