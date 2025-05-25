//
//  CustomWheelPicker.swift
//  early-bird
//
//  Created by JAYOU KOO on 5/25/25.
//
import SwiftUI

/// 1) UIScrollView 래퍼
struct SnapScrollView<Content: View>: UIViewRepresentable {
    @Binding var selectedIndex: Int
    let itemCount: Int
    let itemHeight: CGFloat
    let content: Content

    init(selectedIndex: Binding<Int>, itemCount: Int, itemHeight: CGFloat,
         @ViewBuilder content: () -> Content) {
        self._selectedIndex = selectedIndex
        self.itemCount = itemCount
        self.itemHeight = itemHeight
        self.content = content()
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.decelerationRate = .fast
        scrollView.delegate = context.coordinator
        // 호스팅
        let host = UIHostingController(rootView: content)
        host.view.translatesAutoresizingMaskIntoConstraints = false
        host.view.backgroundColor = .clear
        scrollView.addSubview(host.view)
        NSLayoutConstraint.activate([
            host.view.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            host.view.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            host.view.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            host.view.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            host.view.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
        return scrollView
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // 외부에서 selectedIndex 바뀔 때
        let targetY = CGFloat(selectedIndex) * itemHeight
        uiView.setContentOffset(.init(x: 0, y: targetY), animated: true)
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        let parent: SnapScrollView
        private let selectionFeedback = UISelectionFeedbackGenerator()
        private var lastHapticIndex: Int

        init(_ parent: SnapScrollView) {
            self.parent = parent
            self.lastHapticIndex = parent.selectedIndex
            super.init()
            // 미리 prepare 해 두면 첫 진동도 부드럽게
            selectionFeedback.prepare()
        }

        func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            // bounce 끄기
            scrollView.bounces = false
            // 다음 진동 준비
            selectionFeedback.prepare()
            lastHapticIndex = Int((scrollView.contentOffset.y / parent.itemHeight).rounded())
        }

        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let y = scrollView.contentOffset.y
            let maxOffset = CGFloat(parent.itemCount - 1) * parent.itemHeight

            // bounce 영역이면 무시
            guard y >= 0, y <= maxOffset else { return }

            // 반올림 (floor(raw+0.5) == Int(raw.rounded()) 와 동일)
            let raw = y / parent.itemHeight
            let idx = Int(floor(raw + 0.5))
            let clamped = min(max(idx, 0), parent.itemCount - 1)

            // 인덱스가 바뀌었을 때만 진동
            if clamped != lastHapticIndex {
                selectionFeedback.selectionChanged()
                lastHapticIndex = clamped
            }
        }

        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            if !decelerate { snap(scrollView) }
        }

        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            snap(scrollView)
        }

        private func snap(_ scrollView: UIScrollView) {
            let raw = scrollView.contentOffset.y / parent.itemHeight
            let idx = Int(floor(raw + 0.5))
            let clamped = min(max(idx, 0), parent.itemCount - 1)

            DispatchQueue.main.async {
                self.parent.selectedIndex = clamped
            }
            scrollView.setContentOffset(.init(x: 0, y: CGFloat(clamped) * parent.itemHeight),
                                        animated: true)
        }
    }
}


struct CustomWheelPicker<T: Hashable>: View {
    @Binding var selection: T
    let items: [T]
    let displayFormat: (T) -> String

    @State private var selectedIndex: Int = 0
    private let itemHeight: CGFloat = 40

    var body: some View {
        GeometryReader { geo in
            SnapScrollView(
                selectedIndex: $selectedIndex,
                itemCount: items.count,
                itemHeight: itemHeight
            ) {
                VStack(spacing: 0) {
                    // 위/아래 반 스페이싱
                    Color.clear.frame(height: geo.size.height/2 - itemHeight/2)

                    ForEach(Array(items.enumerated()), id: \.offset) { idx, item in
                        ItemView(
                            item: item,
                            displayFormat: displayFormat,
                            isSelected: idx == selectedIndex,
                            geometry: geo,
                            centerY: geo.size.height/2,
                            itemHeight: itemHeight
                        )
                        .frame(height: itemHeight)
                    }

                    Color.clear.frame(height: geo.size.height/2 - itemHeight/2)
                }
            }
            .onChange(of: selectedIndex) { newIdx in
                selection = items[newIdx]
            }
            .onAppear {
                if let idx = items.firstIndex(of: selection) {
                    selectedIndex = idx
                }
            }
        }
        .frame(height: 120)
    }
}


// MARK: - ItemView
private struct ItemView<T: Hashable>: View {
    let item: T
    let displayFormat: (T) -> String
    let isSelected: Bool
    let geometry: GeometryProxy
    let centerY: CGFloat
    let itemHeight: CGFloat
    
    var body: some View {
        GeometryReader { itemGeometry in
            let itemCenterY = itemGeometry.frame(in: .global).midY
            let distance = abs(itemCenterY - centerY - geometry.frame(in: .global).minY)
            let normalizedDistance = min(distance / (itemHeight * 2), 1.0)
            
            // 거리에 따른 스케일과 투명도 계산
            let scale = 1.0 - (normalizedDistance * 0.7)
            let opacity = 1.0 - (normalizedDistance * 1.7)
            
            FontText(
                text: LocalizedStringKey(displayFormat(item)),
                weight: .semiBold,
                size: 40,
                alignment: .center
            )
            .foregroundStyle(Theme.mainTextColor)
            .scaleEffect(scale)
            .opacity(opacity)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: itemHeight)
    }
}

// MARK: - ScrollOffsetPreferenceKey
private struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
