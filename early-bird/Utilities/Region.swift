//
//  Region.swift
//  early-bird
//
//  Created by JAYOU KOO on 5/18/25.
//
import SwiftUI

func isEuropeanRegion() -> Bool {
    let europeanCountryCodes: Set<String> = [
        "AT", "BE", "BG", "HR", "CY", "CZ", "DK", "EE", "FI", "FR",
        "DE", "GR", "HU", "IS", "IE", "IT", "LV", "LI", "LT", "LU",
        "MT", "NL", "NO", "PL", "PT", "RO", "SK", "SI", "ES", "SE",
        "CH", "GB", "UK"
    ]
    
    if let regionCode = Locale.current.region?.identifier {
        print(regionCode)
        return europeanCountryCodes.contains(regionCode)
    }
    
   
    return false
}
