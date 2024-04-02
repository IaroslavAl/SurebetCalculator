//
//  SurebetCalculatorViewModel.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 02.04.2024.
//

import Foundation

final class SurebetCalculatorViewModel: ObservableObject {
    @Published private(set) var total: TotalRow = TotalRow()
    @Published private(set) var rows: [Row] = Row.createRows()
    @Published private(set) var selectedNumberOfRows: NumberOfRows = .two
    @Published private(set) var selectedRow: RowType? = .total
    @Published private(set) var focus: FocusableField? = nil
    
    enum ViewAction {
        case selectRow(RowType)
        case selectNumberOfRows(NumberOfRows)
        case setTextFieldText(FocusableField, String)
        case setFocus(FocusableField?)
        case clearFocusableField
        case clearAll
        case hideKeyboard
    }
    
    func send(_ action: ViewAction) {
        switch action {
        case let .selectRow(row):
            select(row)
        case let .selectNumberOfRows(numberOfRows):
            select(numberOfRows)
        case let .setTextFieldText(field, text):
            set(field, text: text)
        case let .setFocus(focus):
            set(focus)
        case .clearFocusableField:
            clearFocusableField()
        case .clearAll:
            clearAll()
        case .hideKeyboard:
            hideKeyboard()
        }
    }
}

extension SurebetCalculatorViewModel {
    var indexesOfDisplayedRows: Range<Int> {
        0..<selectedNumberOfRows.rawValue
    }
}

private extension SurebetCalculatorViewModel {
    func select(_ row: RowType) {
        if selectedRow == row {
            deselectCurrentRow()
            selectedRow = nil
        } else {
            deselectCurrentRow()
            switch row {
            case .total:
                total.isON = true
            case let .row(number):
                rows[number].isON = true
            }
            selectedRow = row
        }
        calculate()
    }
    
    func select(_ numberOfRows: NumberOfRows) {
        selectedNumberOfRows = numberOfRows
        let indexesOfUndisplayedRows = selectedNumberOfRows.rawValue..<rows.count
        if rows[indexesOfUndisplayedRows].contains(where: \.isON) {
            deselectCurrentRow()
        }
        clear(indexesOfUndisplayedRows)
        calculate()
    }
    
    func set(_ textField: FocusableField, text: String) {
        switch textField {
        case .totalBetSize:
            setTotalBetSize(text: text)
        case let .rowBetSize(id):
            setRowBetSize(id: id, text: text)
        case let .rowCoefficient(id):
            setRowCoefficient(id: id, text: text)
        }
        calculate()
    }
    
    func set(_ focus: FocusableField?) {
        self.focus = focus
    }
    
    func clearFocusableField() {
        switch focus {
        case .totalBetSize:
            total.betSize.removeAll()
            set(.totalBetSize, text: "")
        case let .rowBetSize(id):
            rows[id].betSize.removeAll()
            set(.rowBetSize(id), text: "")
        case let .rowCoefficient(id):
            rows[id].coefficient.removeAll()
        case .none:
            break
        }
    }
    
    func clearAll() {
        clearTotal()
        clear(rows.indices)
    }
    
    func hideKeyboard() {
        focus = .none
    }
}

private extension SurebetCalculatorViewModel {
    var surebet: Double {
        rows[indexesOfDisplayedRows]
            .compactMap { $0.coefficient.formatToDouble() }
            .reduce(0) { $0 + (1 / $1) }
    }
    
    var isAllBetSizes: Bool {
        rows[indexesOfDisplayedRows]
            .map(\.betSize)
            .allSatisfy {
                $0.isValidDouble()
                && !$0.isEmpty
            }
    }
    
    var isAllCoefficient: Bool {
        rows[indexesOfDisplayedRows]
            .map(\.coefficient)
            .allSatisfy {
                $0.isValidDouble()
                && !$0.isEmpty
                && $0.formatToDouble() ?? 0 > 0
            }
    }
    
    func setTotalBetSize(text: String) {
        if total.betSize != text, selectedRow != .total {
            select(.total)
        }
        total.betSize = text
        if text.isEmpty {
            indexesOfDisplayedRows.forEach {
                rows[$0].betSize.removeAll()
            }
        }
    }
    
    func setRowBetSize(id: Int, text: String) {
        rows[id].betSize = text
        if text.isEmpty, selectedRow != .none {
            rows.map(\.id).forEach {
                if $0 != id {
                    rows[$0].betSize.removeAll()
                }
            }
            total.betSize.removeAll()
        } else if selectedRow == .none {
            setTotalFromBetSizes()
        }
    }
    
    func setTotalFromBetSizes() {
        let sumOfBetSizes = rows[indexesOfDisplayedRows]
            .compactMap { $0.betSize.formatToDouble() }
            .reduce(0) { $0 + $1 }
        total.betSize = sumOfBetSizes.formatToString()
    }
    
    func setRowCoefficient(id: Int, text: String) {
        rows[id].coefficient = text
    }
    
    func deselectCurrentRow() {
        switch selectedRow {
        case .total:
            total.isON = false
        case let .row(number):
            rows[number].isON = false
        case .none:
            break
        }
    }
    
    func clearTotal() {
        total.betSize.removeAll()
        total.profitPercentage = 0
    }
    
    func clear(_ rowsRange: Range<Int>) {
        rowsRange.forEach {
            rows[$0].betSize.removeAll()
            rows[$0].coefficient.removeAll()
            rows[$0].income = 0
        }
    }
}

// MARK: - Calculations

private extension SurebetCalculatorViewModel {
    var calculationMethod: CalculationMethod? {
        guard isAllCoefficient else {
            return .none
        }
        switch selectedRow {
        case .total:
            if total.betSize.isValidDouble() {
                return .total
            }
        case let .row(id):
            if rows[id].betSize.isValidDouble() {
                return .row(id)
            }
        case .none:
            if isAllBetSizes {
                return .rows
            }
        }
        return .none
    }
    
    func calculate() {
        switch calculationMethod {
        case .total:
            calculateTotal()
        case .rows:
            calculateRows()
        case let .row(id):
            calculateRow(id)
        case .none:
            break
        }
    }
    
    func calculateTotal() {
        calculateRowsBetSizesAndIncomes()
        total.profitPercentage = (100 / surebet) - 100
    }
    
    func calculateRows() {
        let totalBetSize = indexesOfDisplayedRows
            .compactMap { rows[$0].betSize.formatToDouble() }
            .reduce(0) { $0 + $1 }
        indexesOfDisplayedRows.forEach {
            let coefficient = rows[$0].coefficient.formatToDouble()
            let betSize = rows[$0].betSize.formatToDouble()
            if let coefficient, let betSize {
                let winning = coefficient * betSize
                let income = winning - totalBetSize
                rows[$0].income = income
            }
        }
        total.betSize = totalBetSize.formatToString()
        total.profitPercentage = (100 / surebet) - 100
    }
    
    func calculateRow(_ id: Int) {
        let coefficient = rows[id].coefficient.formatToDouble()
        let betSize = rows[id].betSize.formatToDouble()
        if let coefficient, let betSize {
            let totalBetSize = (betSize / (1 / coefficient / surebet))
            total.betSize = totalBetSize.formatToString()
            total.profitPercentage = (100 / surebet) - 100
        }
        calculateRowsBetSizesAndIncomes()
    }
    
    func calculateRowsBetSizesAndIncomes() {
        indexesOfDisplayedRows.forEach {
            let coefficient = rows[$0].coefficient.formatToDouble()
            let totalBetSize = total.betSize.formatToDouble()
            if let coefficient, let totalBetSize {
                let betSize = 1 / coefficient / surebet * totalBetSize
                rows[$0].betSize = betSize.formatToString()
                let winning = coefficient * betSize
                let income = winning - totalBetSize
                rows[$0].income = income
            }
        }
    }
}
