//
//  KeyboardClearButton.swift
//
//
//  Created by Iaroslav Beldin on 03.10.2023.
//

import SwiftUI

struct KeyboardClearButton: View {
    @ObservedObject private var viewModel: SurebetCalculatorViewModel
    
    init(_ viewModel: SurebetCalculatorViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Button {
            viewModel.clearKeyboardButton()
        } label: {
            Text("Clear")
                .foregroundColor(.red)
        }
    }
}

struct KeyboardClearButton_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardClearButton(SurebetCalculatorViewModel())
    }
}
