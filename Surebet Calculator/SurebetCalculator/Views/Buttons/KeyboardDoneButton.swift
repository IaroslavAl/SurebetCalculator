//
//  KeyboardDoneButton.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 02.04.2024.
//

import SwiftUI

struct KeyboardDoneButton: View {
    @EnvironmentObject private var viewModel: SurebetCalculatorViewModel
    
    var body: some View {
        Button(text) {
            viewModel.send(.hideKeyboard)
        }
    }
}

private extension KeyboardDoneButton {
    var text: String { "Done" }
}

#Preview {
    KeyboardDoneButton()
        .environmentObject(SurebetCalculatorViewModel())
}
