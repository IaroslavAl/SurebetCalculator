//
//  KeyboardDoneButton.swift
//
//
//  Created by Iaroslav Beldin on 03.10.2023.
//

import SwiftUI

struct KeyboardDoneButton: View {
    @ObservedObject private var viewModel: SurebetCalculatorViewModel
    
    init(_ viewModel: SurebetCalculatorViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Button("Done") {
            viewModel.isFocused = .none
        }
    }
}

struct KeyboardDoneButton_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardDoneButton(SurebetCalculatorViewModel())
    }
}
