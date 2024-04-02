//
//  FocusableField.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 02.04.2024.
//

import Foundation

enum FocusableField: Hashable {
    case totalBetSize
    case rowBetSize(_ id: Int)
    case rowCoefficient(_ id: Int)
}
