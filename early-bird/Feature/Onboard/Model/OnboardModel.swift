//
//  Visit.swift
//  early-bird
//
//  Created by JAYOU KOO on 4/15/25.
//


import Foundation

struct DelayingReason: Codable {
    var comment: String
    var clientId : String
    var createdAt : String
}

struct StressAvoidReason: Codable {
    var comment: String
    var clientId : String
    var createdAt : String
}

struct UserDescription: Codable {
    var comment: String
    var clientId : String
    var createdAt : String
}
