//
//  TotalRowView.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 02.04.2024.
//

import SwiftUI

struct TotalRowView: View {
    @EnvironmentObject private var viewModel: SurebetCalculatorViewModel

    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            ToggleButton(row: .total)
            HStack(spacing: spacing) {
                totalBetSizeColumn
                profitPercentageColumn
            }
        }
    }
}

private extension TotalRowView {
    var betSizeLabel: String { "Total bet size" }
    var profitPercentageLabel: String { "Profit percentage" }
    var placeholder: String { "Total bet size" }
    var iPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    var spacing: CGFloat { iPad ? 12 : 8 }

    var totalBetSizeColumn: some View {
        VStack(spacing: spacing) {
            Text(betSizeLabel)
            TextFieldView(
                placeholder: placeholder,
                focusableField: .totalBetSize
            )
        }
    }

    var profitPercentageColumn: some View {
        VStack(spacing: spacing) {
            Text(profitPercentageLabel)
            TextView(
                text: viewModel.total.profitPercentage,
                isPercent: true
            )
        }
    }
}

#Preview {
    TotalRowView()
        .padding(.trailing)
}
