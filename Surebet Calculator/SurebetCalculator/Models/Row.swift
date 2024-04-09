//
//  Row.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 02.04.2024.
//

import Foundation

struct Row: Equatable {
    let id: Int
    var isON: Bool = false
    var betSize: String = ""
    var coefficient: String = ""
    var income: String = "0"
    
    static func createRows(_ number: Int = 4) -> [Row] {
        (0..<number).map { Row(id: $0) }
    }
}
