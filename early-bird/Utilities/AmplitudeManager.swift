//
//  AmplitudeManager.swift
//  early-bird
//
//  Created by JAYOU KOO on 5/29/25.
//


import AmplitudeSwift

class AmplitudeManager {
    static var shared = AmplitudeManager()
    private(set) var amplitude: Amplitude
    private init() {
        self.amplitude = Amplitude(configuration: .init(apiKey: ""))
    }
}
