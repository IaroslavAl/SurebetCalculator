//
//  TotalModel.swift
//  SureBetProfitCalculator
//
//  Created by BELDIN Yaroslav on 04.02.2024.
//

import Foundation

struct TotalModel {
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
