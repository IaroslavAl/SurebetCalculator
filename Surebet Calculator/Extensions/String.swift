//
//  String.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 02.04.2024.
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
    
    func isValidDouble() -> Bool {
        self.formatToDouble() != nil
        || self.isEmpty
        || self.formatToDouble() ?? 0 > 0
    }
}
