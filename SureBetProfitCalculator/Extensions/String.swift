//
//  String.swift
//  SureBetProfitCalculator
//
//  Created by BELDIN Yaroslav on 03.02.2024.
//

import Foundation

extension String {
    func formatToDouble() -> Double? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        if let formattedValue = formatter.number(from: self) {
            return formattedValue.doubleValue
        }
        return nil
    }
}
