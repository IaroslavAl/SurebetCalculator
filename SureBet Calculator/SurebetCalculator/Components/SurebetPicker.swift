//
//  SurebetPicker.swift
//  SureBet Profit Calculator
//
//  Created by BELDIN Yaroslav on 03.10.2023.
//

import SwiftUI

struct SurebetPicker: View {
    @ObservedObject private var viewModel: SurebetCalculatorViewModel
    
    init(_ viewModel: SurebetCalculatorViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Picker("Outcomes", selection: $viewModel.selected) {
            ForEach(SelectedOutcomes.allCases, id: \.self) { odds in
                Text(odds.rawValue.formatted() + " Outcomes")
            }
        }
        .pickerStyle(.segmented)
        .onChange(of: viewModel.selected) {
            viewModel.clearСlosedOutcomes($0)
        }
    }
}

struct SurebetPicker_Previews: PreviewProvider {
    static var previews: some View {
        SurebetPicker(SurebetCalculatorViewModel())
    }
}
