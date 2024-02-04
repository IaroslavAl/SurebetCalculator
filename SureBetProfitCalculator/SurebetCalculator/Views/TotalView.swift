//
//  TotalView.swift
//  SureBetProfitCalculator
//
//  Created by BELDIN Yaroslav on 03.02.2024.
//

import SwiftUI

struct TotalView: View {
    @Binding var generalOutcome: TotalModel
    let toggleAction: () -> Void
    
    var body: some View {
        HStack(alignment: .bottom, spacing: spacing) {
            ToggleView(isOn: generalOutcome.isOn, action: toggleAction)
            totalBetSizeColumn
            profitPercentageColumn
        }
    }
}

private extension TotalView {
    var betSizeLabel: String { "Total bet size" }
    var profitPercentageLabel: String { "Profit percentage" }
    var placeholder: String { "Total bet size" }
    var spacing: CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 16 : 8
    }
    
    var totalBetSizeColumn: some View {
        VStack {
            Text(betSizeLabel)
            TextField(placeholder, text: $generalOutcome.totalBetSize)
                .textFieldStyle(.calculatorStyle(generalOutcome.isValid))
        }
    }
    
    var profitPercentageColumn: some View {
        VStack {
            Text(profitPercentageLabel)
            TextView(number: generalOutcome.profitPercentage, isPercent: true)
        }
    }
}

#Preview {
    TotalView(
        generalOutcome: .constant(.init()),
        toggleAction: {}
    )
    .padding()
}
