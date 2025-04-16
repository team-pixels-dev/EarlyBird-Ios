import Foundation
import SwiftUI

class Onboard1ViewModel: ObservableObject {
    @Published var inputText: String = UserInputManager.shared.procrastinationText
    @Published var page: Int = 0
    @Published var visibleCount: Int = 0
    @Published var showTextInput: Bool = false

    let conversationTexts_1: [(LocalizedStringKey, Color?, Double)] = [
        ("반가워! 나는 얼리버드야!", nil, 0.0),
        ("우리가 잘 지내기 위해,\n너에 대해 조금만 알려줄 수 있을까?", nil, 1.5),
        ("(이번만이야. 1분도 안 걸려!)", Theme.mainTextColor2, 2.5)
    ]
    
    let conversationTexts_2: [(LocalizedStringKey, Color?, Double)] = [
        ("나 요즘 자꾸 미루는 스스로한테 지쳐…\n너도 이제 그만 스트레스 받고 싶지 않아?", nil, 0.0),
        ("(진짜 이유, 나한테만 살짝 말해줘!)", Theme.mainTextColor2, 3.5)
    ]
    
    var content: [[(LocalizedStringKey, Color?, Double)]] {
        [conversationTexts_1, conversationTexts_2]
    }
    
    func startAnimationSequence() {
        visibleCount = 0
        showTextInput = false
        
        var time: Double = 0.0
        for index in 0..<content[page].count {
            let (_, _, duration) = content[page][index]
            time += duration
            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                withAnimation(.easeOut(duration: 0.5)) {
                    self.visibleCount = index + 1
                }
            }
        }

        // 입력창 노출 시점
        DispatchQueue.main.asyncAfter(deadline: .now() + time + 1.0) {
            withAnimation(.easeOut(duration: 0.5)) {
                self.showTextInput = true
            }
        }
    }

    func nextStep() {
        UserInputManager.shared.procrastinationText = inputText
        showTextInput = false
        visibleCount = 0

        if page < content.count - 1 {
            page += 1
            startAnimationSequence()
        }
    }
}
