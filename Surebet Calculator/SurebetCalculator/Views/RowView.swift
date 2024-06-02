//
//  RowView.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 02.04.2024.
//

import SwiftUI

struct RowView: View {
    @EnvironmentObject private var viewModel: SurebetCalculatorViewModel

    let id: Int

    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            ToggleButton(row: .row(id))
            HStack(spacing: spacing) {
                betSize
                coefficient
                income
            }
        }
    }
}

private extension RowView {
    var coefficientText: String { "Coefficient" }
    var betSizeText: String { "Bet size" }
    var incomeText: String { "Income" }
    var iPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    var spacing: CGFloat { iPad ? 12 : 8 }

    var betSize: some View {
        VStack(spacing: spacing) {
            if id == 0 {
                Text(betSizeText)
            }
            TextFieldView(
                placeholder: betSizeText,
                focusableField: .rowBetSize(id)
            )
        }
    }

    var coefficient: some View {
        VStack(spacing: spacing) {
            if id == 0 {
                Text(coefficientText)
            }
            TextFieldView(
                placeholder: coefficientText,
                focusableField: .rowCoefficient(id)
            )
        }
    }

    var income: some View {
        VStack(spacing: spacing) {
            if id == 0 {
                Text(incomeText)
            }
            TextView(
                text: viewModel.rows[id].income,
                isPercent: false
            )
        }
    }
}

#Preview {
    RowView(id: 0)
        .padding(.trailing)
}
