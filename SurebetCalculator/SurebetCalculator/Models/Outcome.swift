//
//  Outcome.swift
//  SurebetCalculator
//
//  Created by Iaroslav Beldin on 28.09.2023.
//

import Foundation

struct Outcome {
    let id: Int
    var isOn: Bool
    var isValidCoefficient : Bool
    var isValidBetSize: Bool
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
        self.isValidCoefficient = isValidCoefficient
        self.isValidBetSize = isValidBetSize
        self.coefficient = coefficient
        self.betSize = betSize
        self.income = income
    }
    
    static func createOutcomes(_ number: Int = 4) -> [Outcome] {
        var outcomes: [Outcome] = []
        for index in 0..<number {
            outcomes.append(.init(id: index))
        }
        return outcomes
    }
}
