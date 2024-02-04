//
//  Double.swift
//  SureBetProfitCalculator
//
//  Created by BELDIN Yaroslav on 03.02.2024.
//

import Foundation

extension Double {
    func formatToString(isPercent: Bool = false) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        let formattedValue = formatter.string(from: NSNumber(value: self)) ?? "0.00"
        let formattedString = isPercent ? formattedValue + "%" : formattedValue
        return formattedString
    }
}
