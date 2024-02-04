//
//  RowModel.swift
//  SureBetProfitCalculator
//
//  Created by BELDIN Yaroslav on 04.02.2024.
//

import Foundation

struct RowModel {
    let id: Int
    var isOn: Bool
    var isValidBetSize: Bool
    var isValidCoefficient : Bool
    var coefficient: String
    var betSize: String
    var income: Double
    
    init(
        id: Int,
        isOn: Bool = false,
        isValidCoefficient: Bool = true,
        isValidBetSize: Bool = true,
        coefficient: String = "",
        betSize: String = "",
        income: Double = 0
    ) {
        self.id = id
        self.isOn = isOn
        self.isValidBetSize = isValidBetSize
        self.isValidCoefficient = isValidCoefficient
        self.coefficient = coefficient
        self.betSize = betSize
        self.income = income
    }
    
    static func createRows(_ number: Int = 4) -> [RowModel] {
        (0..<number).map { RowModel(id: $0) }
    }
}
