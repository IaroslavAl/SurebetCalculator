//
//  PickerView.swift
//  SureBetProfitCalculator
//
//  Created by BELDIN Yaroslav on 03.02.2024.
//

import SwiftUI

struct PickerView: View {
    @Binding var selection: NumberOfRows
    
    var body: some View {
        Picker(label, selection: $selection) {
            ForEach(NumberOfRows.allCases, id: \.self) {
                Text(composeText(numberOfOutcomes: $0))
            }
        }
        .pickerStyle(.segmented)
    }
}

private extension PickerView {
    var label: String { "Outcomes" }
    func composeText(numberOfOutcomes: NumberOfRows) -> String {
        [numberOfOutcomes.rawValue.formatted(), label].joined(separator: " ")
    }
}

#Preview {
    PickerView(selection: .constant(.two))
}
