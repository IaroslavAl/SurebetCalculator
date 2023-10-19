//
//  SurebetCalculatorViewModel.swift
//
//
//  Created by Iaroslav Beldin on 02.10.2023.
//

import Foundation

final class SurebetCalculatorViewModel: ObservableObject {
    @Published var generalOutcome: GeneralOutcome
    @Published var outcomes: [Outcome]
    @Published var selected: SelectedOutcomes
    @Published var isBlock: Bool
    @Published var isFocused: Focusable?
    
    init() {
        self.generalOutcome = GeneralOutcome()
        self.outcomes = Outcome.createOutcomes()
        self.selected = .two
        self.isBlock = false
    }
}

extension SurebetCalculatorViewModel {
    func calculateOnChangeTotalBetSize(newValue: String) {
        if isFocused == .totalBetSize, !isBlock {
            if isValid(newValue) {
                generalOutcome.isValid = true
                calculateGeneralOutcome(newValue: newValue)
            } else {
                generalOutcome.isValid = false
            }
        } else {
            isBlock = false
        }
    }
    
    func calculateOnChangeCoefficient(_ index: Int, newValue: String) {
        if isFocused == .coefficient(index: index) {
            if isValid(newValue) {
                outcomes[index].isValidCoefficient = true
                calculateCoefficient(index: index)
            } else {
                outcomes[index].isValidCoefficient = false
            }
        }
    }
    
    func calculateOnChangeBetSize(_ index: Int, newValue: String) {
        if isFocused == .betSize(index: index), !isBlock {
            if isValid(newValue) {
                outcomes[index].isValidBetSize = true
                calculateBetSize(index)
            } else {
                outcomes[index].isValidBetSize = false
            }
        } else {
            isBlock = false
        }
    }
    
    func calculateGeneralOutcomeToggle() {
        if !generalOutcome.isOn, isAllCoefficients {
            calculateBetSizes()
            calculateIncomes()
        }
        toggle(.generalOutcome)
        turnOffBlock(isFocused: isFocused)
    }
    
    func calculateOutcomeToggle(_ index: Int) {
        let betSize = outcomes[index].betSize.formatToDouble() ?? 0
        if betSize > 0, isAllCoefficients {
            calculateTotalBetSizeForToggle(index)
            calculateBetSizes()
            calculateIncomes()
        }
        toggle(.outcome(index))
        turnOffBlock(isFocused: isFocused)
    }
    
    func calculateIfSomeOutcomeIsOn() {
        if let onToggleIndex = outcomes.firstIndex(where: { $0.isOn }),
           outcomes[onToggleIndex].betSize.formatToDouble() ?? 0 > 0,
           isAllCoefficients {
            calculateTotalBetSizeForToggle(onToggleIndex)
            calculateBetSizes(except: onToggleIndex)
            calculateIncomes()
        }
    }
    
    func toggle(_ toggle: ToggleStyle) {
        switch toggle {
        case .generalOutcome:
            if !generalOutcome.isOn {
                turnOffOutcomes()
            }
            generalOutcome.isOn.toggle()
        case let .outcome(index):
            if !outcomes[index].isOn {
                turnOffGeneralOutcome()
                turnOffOutcomes()
            }
            outcomes[index].isOn.toggle()
        }
    }
    
    func clearNavigationButton() {
        isFocused = .none
        isBlock = true
        clearOutcomes()
        clearGeneralOutcome()
        toggle(.generalOutcome)
        if !generalOutcome.isOn {
            generalOutcome.isOn.toggle()
        }
    }
    
    func clearKeyboardButton() {
        switch isFocused {
        case .totalBetSize:
            generalOutcome.totalBetSize = ""
        case let .coefficient(index: index):
            outcomes[index].coefficient = ""
        case let .betSize(index: index):
            outcomes[index].betSize = ""
        case .none:
            break
        }
    }
    
    func clearСlosedOutcomes(_ newValue: SelectedOutcomes) {
        outcomes.forEach { outcome in
            if outcome.id >= newValue.rawValue {
                clearOutcome(outcome.id)
            }
        }
    }
    
    func turnOffBlock(isFocused: Focusable?) {
        if isFocused == .none {
            isBlock = false
        }
    }
    
    var currentIndexes: Range<Int> {
        0..<selected.rawValue
    }
}

private extension SurebetCalculatorViewModel {
    func calculateGeneralOutcome(newValue: String) {
        if !generalOutcome.isOn {
            toggle(.generalOutcome)
        }
        if isAllCoefficients {
            calculateBetSizes()
            calculateIncomes()
        }
    }
    
    func calculateCoefficient(index: Int) {
        if isAllCoefficients {
            let totalBetSize = generalOutcome.totalBetSize.formatToDouble() ?? 0
            if generalOutcome.isOn && totalBetSize > 0
                || generalOutcome.isOn && isAllBetSizes {
                calculateBetSizes()
                calculateIncomes()
            }
            if !generalOutcome.isOn,
               !outcomes.contains(where: { $0.isOn == true }) {
                calculateBetSize(index)
                if isAllBetSizes {
                    calculateTotalBetSize()
                    calculateIncomes()
                }
            }
            calculateIfSomeOutcomeIsOn()
        } else {
            if generalOutcome.isOn || outcomes.contains(where: { $0.isOn == true }) {
                currentIndexes.forEach {
                    outcomes[$0].income = 0
                }
            } else {
                outcomes[index].income = 0
            }
            generalOutcome.profitPercentage = 0
        }
    }
    
    func calculateBetSize(_ index: Int) {
        if generalOutcome.isOn {
            toggle(.outcome(index))
        }
        if let onToggleIndex = outcomes.firstIndex(where: { $0.isOn }),
           onToggleIndex != index {
            toggle(.outcome(index))
        }
        if isAllCoefficients {
            if isAllBetSizes {
                calculateTotalBetSize()
                calculateIncomes()
            }
            calculateIfSomeOutcomeIsOn()
        }
    }
    
    func calculateTotalBetSizeForToggle(_ index: Int) {
        let betSize = outcomes[index].betSize.formatToDouble() ?? 0
        let coefficient = outcomes[index].coefficient.formatToDouble() ?? 0
        let totalBetSize = betSize / (1 / coefficient / sureBet)
        generalOutcome.totalBetSize = totalBetSize.formatToString()
    }
    
    func calculateTotalBetSize() {
        let totalBetSize = outcomes.reduce(0) { partialResult, oucome in
            let betSize = oucome.betSize.formatToDouble() ?? 0
            return partialResult + betSize
        }
        generalOutcome.totalBetSize = totalBetSize.formatToString()
    }
    
    func calculateBetSizes(except index: Int? = nil) {
        currentIndexes.forEach { i in
            if i != index {
                calculateOutcomeBetSize(i)
            }
        }
    }
    
    func calculateOutcomeBetSize(_ index: Int) {
        let coefficient = outcomes[index].coefficient.formatToDouble() ?? 0
        let totalBetSize = generalOutcome.totalBetSize.formatToDouble() ?? 0
        let betSize = 1 / coefficient / sureBet * totalBetSize
        outcomes[index].betSize = betSize.formatToString()
    }
    
    func calculateIncomes() {
        currentIndexes.forEach {
            calculateOutcomeIncome($0)
        }
        calculateProfitPercentage()
    }
    
    func calculateOutcomeIncome(_ index: Int) {
        let betSize = outcomes[index].betSize.formatToDouble() ?? 0
        let coefficient = outcomes[index].coefficient.formatToDouble() ?? 0
        let totalBetSize = generalOutcome.totalBetSize.formatToDouble() ?? 0
        let winning = coefficient * betSize
        let income = winning - totalBetSize
        outcomes[index].income = income
    }
    
    func calculateProfitPercentage() {
        generalOutcome.profitPercentage = (100 / sureBet) - 100
    }
    
    func turnOffGeneralOutcome() {
        if generalOutcome.isOn {
            generalOutcome.isOn = false
        }
    }
    
    func turnOffOutcomes() {
        currentIndexes.forEach { turnOffOutcome($0) }
    }
    
    func turnOffOutcome(_ index: Int) {
        if outcomes[index].isOn {
            outcomes[index].isOn = false
        }
    }
    
    func clearGeneralOutcome() {
        if generalOutcome.totalBetSize != "" {
            generalOutcome.totalBetSize = ""
        }
        if generalOutcome.profitPercentage != 0 {
            generalOutcome.profitPercentage = 0
        }
    }
    
    func clearOutcomes() {
        currentIndexes.forEach { clearOutcome($0) }
    }
    
    func clearOutcome(_ index: Int) {
        if outcomes[index].coefficient != "" {
            outcomes[index].coefficient = ""
        }
        if  outcomes[index].betSize != "" {
            outcomes[index].betSize = ""
        }
        if outcomes[index].income != 0 {
            outcomes[index].income = 0
        }
    }
    
    func isValid(_ value: String) -> Bool {
        let isDouble = value.formatToDouble() != nil
        let isEmpty = value == ""
        return isDouble || isEmpty
    }
    
    var isAllCoefficients: Bool {
        outcomes[currentIndexes].allSatisfy { outcome in
            let formattedCoefficient = outcome.coefficient.formatToDouble() ?? 0
            return formattedCoefficient > 0
        }
    }
    
    var isAllBetSizes: Bool {
        outcomes[currentIndexes].allSatisfy { outcome in
            let formattedBetSize = outcome.betSize.formatToDouble() ?? 0
            return formattedBetSize > 0
        }
    }
    
    var sureBet: Double {
        outcomes[currentIndexes].reduce(0) { partialResult, outcome in
            let formattedСoefficient = outcome.coefficient.formatToDouble() ?? 0
            return partialResult + (1 / formattedСoefficient)
        }
    }
}

enum ToggleStyle {
    case generalOutcome
    case outcome(_ index: Int)
}

enum SelectedOutcomes: Int, CaseIterable {
    case two = 2
    case three = 3
    case four = 4
}

enum Focusable: Hashable {
    case totalBetSize
    case coefficient(index: Int)
    case betSize(index: Int)
}
