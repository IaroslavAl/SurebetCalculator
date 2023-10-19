//
//  String.swift
//  SurebetCalculator
//
//  Created by Iaroslav Beldin on 03.10.2023.
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
