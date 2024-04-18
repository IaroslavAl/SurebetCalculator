//
//  PickerView.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 02.04.2024.
//

import SwiftUI

struct PickerView: View {
    @EnvironmentObject private var viewModel: SurebetCalculatorViewModel
    
    var body: some View {
        Picker(label, selection: bindingSelection, content: content)
            .pickerStyle(.segmented)
    }
}

private extension PickerView {
    var label: String { "Outcomes" }
    var bindingSelection: Binding<NumberOfRows> {
        Binding(
            get: { viewModel.selectedNumberOfRows },
            set: { viewModel.send(.selectNumberOfRows($0)) }
        )
    }
    
    func content() -> some View {
        ForEach(NumberOfRows.allCases, id: \.self) {
            Text(composeText(numberOfOutcomes: $0))
        }
    }
    
    func composeText(numberOfOutcomes: NumberOfRows) -> String {
        [numberOfOutcomes.rawValue.formatted(), label].joined(separator: " ")
    }
}

#Preview {
    PickerView()
        .environmentObject(SurebetCalculatorViewModel())
}
