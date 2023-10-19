//
//  GeneralOutcome.swift
//  SurebetCalculator
//
//  Created by Iaroslav Beldin on 29.09.2023.
//

import Foundation

struct GeneralOutcome {
    var isOn: Bool
    var isValid: Bool
    var totalBetSize: String
    var profitPercentage: Double
    
    init(
        isOn: Bool = true,
        isValid: Bool = true,
        totalBetSize: String = "",
        profitPercentage: Double = 0
    ) {
        self.isOn = isOn
        self.isValid = isValid
        self.totalBetSize = totalBetSize
        self.profitPercentage = profitPercentage
    }
}
