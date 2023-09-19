//
//  SurebetGeneralOutcome.swift
//  SureBet Profit Calculator
//
//  Created by BELDIN Yaroslav on 03.10.2023.
//

import SwiftUI

struct SurebetGeneralOutcome: View {
    @ObservedObject private var viewModel: SurebetCalculatorViewModel
    @FocusState private var isFocused: Focusable?
    
    init(_ viewModel: SurebetCalculatorViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(alignment: .bottom) {
            SurebetToggle(
                viewModel: viewModel,
                isOn: viewModel.generalOutcome.isOn,
                action: viewModel.calculateGeneralOutcomeToggle
            )
            totalBetSize
            profitPercentage
        }
        .padding(.trailing)
        .onChange(of: isFocused) {
            viewModel.isFocused = $0
        }
        .onChange(of: viewModel.isFocused) {
            isFocused = $0
        }
    }
    
    var totalBetSize: some View {
        VStack {
            Text("Total bet size")
            TextField("Total bet size", text: $viewModel.generalOutcome.totalBetSize)
                .textFieldStyle(.surebet($viewModel.generalOutcome.isValid))
                .focused($isFocused, equals: .totalBetSize)
                .onChange(of: viewModel.generalOutcome.totalBetSize) {
                    viewModel.calculateOnChangeTotalBetSize(newValue: $0)
                }
        }
    }
    
    var profitPercentage: some View {
        VStack {
            Text("Profit percentage")
            SurebetText(
                number: viewModel.generalOutcome.profitPercentage,
                isPercent: true
            )
        }
    }
}

struct SurebetGeneralOutcome_Previews: PreviewProvider {
    static var previews: some View {
        SurebetGeneralOutcome(SurebetCalculatorViewModel())
    }
}
