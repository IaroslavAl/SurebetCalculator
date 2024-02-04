//
//  OutcomeView.swift
//  SureBetProfitCalculator
//
//  Created by BELDIN Yaroslav on 04.02.2024.
//

import SwiftUI

struct OutcomeView: View {
    @Binding var row: RowModel
    let toggleAction: () -> Void
    
    var body: some View {
        HStack(alignment: .bottom, spacing: spacing) {
            ToggleView(isOn: row.isOn, action: toggleAction)
            betSize
            coefficient
            income
        }
    }
}

private extension OutcomeView {
    var coefficientText: String { "Coefficient" }
    var betSizeText: String { "Bet size" }
    var incomeText: String { "Income" }
    var spacing: CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 16 : 8
    }
    
    var coefficient: some View {
        VStack(spacing: spacing) {
            if row.id == 0 {
                Text(coefficientText)
            }
            TextField(coefficientText, text: $row.coefficient)
                .textFieldStyle(.calculatorStyle(row.isValidCoefficient))
        }
    }
    
    var betSize: some View {
        VStack(spacing: spacing) {
            if row.id == 0 {
                Text(betSizeText)
            }
            TextField(betSizeText, text: $row.betSize)
                .textFieldStyle(.calculatorStyle(row.isValidBetSize))
        }
    }
    
    var income: some View {
        VStack(spacing: spacing) {
            if row.id == 0 {
                Text(incomeText)
            }
            TextView(number: row.income, isPercent: false)
        }
    }
}

#Preview {
    OutcomeView(row: .constant(.init(id: 0)), toggleAction: {})
}
