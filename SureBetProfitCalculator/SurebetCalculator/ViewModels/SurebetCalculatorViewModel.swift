//
//  SurebetCalculatorViewModel.swift
//  SureBetProfitCalculator
//
//  Created by BELDIN Yaroslav on 03.02.2024.
//

import Foundation

enum NumberOfRows: Int, CaseIterable {
    case two = 2
    case three = 3
    case four = 4
}

enum SelectedRow: Equatable {
    case total
    case row(number: Int)
    case none
}

final class SurebetCalculatorViewModel: ObservableObject {
    @Published var total: TotalModel
    @Published var rows: [RowModel]
    @Published var numberOfOutcomes: NumberOfRows
    @Published var selectedRow: SelectedRow
    
    init() {
        self.total = TotalModel()
        self.rows = RowModel.createRows()
        self.numberOfOutcomes = .two
        self.selectedRow = .total
    }
}

extension SurebetCalculatorViewModel {
    func select(row: SelectedRow) {
        turnOff(row: row)
        guard self.selectedRow != row else {
            self.selectedRow = .none
            return
        }
        turnOn(row: row)
        self.selectedRow = row
    }
}

private extension SurebetCalculatorViewModel {
    func turnOn(row: SelectedRow) {
        switch row {
        case .total:
            total.isOn = true
        case .row(let number):
            rows[number].isOn = true
        case .none:
            break
        }
    }
    
    func turnOff(row: SelectedRow) {
        switch self.selectedRow {
        case .total:
            total.isOn = false
        case .row(let number):
            rows[number].isOn = false
        case .none:
            break
        }
    }
}
