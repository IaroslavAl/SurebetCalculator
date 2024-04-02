//
//  Double.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 02.04.2024.
//

import Foundation

extension Double {
    func formatToString(isPercent: Bool = false) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        let formattedValue = formatter.string(from: NSNumber(value: self)) ?? "0.00"
        let formattedString = isPercent ? formattedValue + "%" : formattedValue
        return formattedString
    }
}
