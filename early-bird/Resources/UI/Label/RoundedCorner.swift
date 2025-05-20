//
//  RoundedCorner.swift
//  early-bird
//
//  Created by JAYOU KOO on 5/19/25.
//

import SwiftUI


struct RoundedCorner: Shape {
    var radius: CGFloat = 30.0
    var corners: UIRectCorner = [.topLeft, .topRight]

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
