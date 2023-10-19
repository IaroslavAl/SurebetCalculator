//
//  Double.swift
//
//
//  Created by Iaroslav Beldin on 03.10.2023.
//

import Foundation

extension Double {
    func formatToString(isPercent: Bool = false) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        let formattedValue = formatter.string(from: NSNumber(value: self)) ?? "0.00"
        return isPercent ? formattedValue + "%" : formattedValue
    }
}
