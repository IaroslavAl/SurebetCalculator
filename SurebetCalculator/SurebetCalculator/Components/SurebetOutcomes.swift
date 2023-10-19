//
//  SurebetOutcomes.swift
//  SurebetCalculator
//
//  Created by Iaroslav Beldin on 03.10.2023.
//

import SwiftUI

struct SurebetOutcomes: View {
    @ObservedObject private var viewModel: SurebetCalculatorViewModel
    @FocusState private var isFocused: Focusable?
    
    init(_ viewModel: SurebetCalculatorViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            ForEach(viewModel.currentIndexes, id: \.self) {
                showOutcome($0)
            }
            .transition(.move(edge: .leading))
            .animation(.default, value: viewModel.selected.rawValue)
        }
        .onChange(of: isFocused) { newValue in
            if newValue != .none {
                viewModel.isFocused = newValue
            }
        }
        .onChange(of: viewModel.isFocused) {
            isFocused = $0
        }
    }
}

private extension SurebetOutcomes {
    func showOutcome(_ index: Int) -> some View {
        HStack(alignment: .bottom) {
            SurebetToggle(
                viewModel: viewModel,
                isOn: viewModel.outcomes[index].isOn
            ) {
                viewModel.calculateOutcomeToggle(index)
            }
            showCoefficient(index)
            showBetSize(index)
            showIncome(index)
        }
        .padding(.trailing)
    }
    
    func showCoefficient(_ index: Int) -> some View {
        VStack {
            if viewModel.outcomes[index].id == 0 {
                Text("Coefficient")
            }
            TextField("\(index + 1) Coef.", text: $viewModel.outcomes[index].coefficient)
                .textFieldStyle(.surebet($viewModel.outcomes[index].isValidCoefficient))
                .focused($isFocused, equals: .coefficient(index: index))
                .onChange(of: viewModel.outcomes[index].coefficient) {
                    viewModel.calculateOnChangeCoefficient(index, newValue: $0)
                }
        }
    }
    
    func showBetSize(_ index: Int) -> some View {
        VStack {
            if viewModel.outcomes[index].id == 0 {
                Text("Bet size")
            }
            TextField("\(index + 1) Bet size", text: $viewModel.outcomes[index].betSize)
                .textFieldStyle(.surebet($viewModel.outcomes[index].isValidBetSize))
                .focused($isFocused, equals: .betSize(index: index))
                .onChange(of: viewModel.outcomes[index].betSize) {
                    viewModel.calculateOnChangeBetSize(index, newValue: $0)
                }
        }
    }
    
    func showIncome(_ index: Int) -> some View {
        VStack {
            if viewModel.outcomes[index].id == 0 {
                Text("Income")
            }
            SurebetText(number: viewModel.outcomes[index].income)
        }
    }
}

struct SurebetOutcomes_Previews: PreviewProvider {
    static var previews: some View {
        SurebetOutcomes(SurebetCalculatorViewModel())
    }
}
