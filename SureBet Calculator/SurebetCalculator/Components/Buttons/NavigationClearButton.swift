//
//  NavigationClearButton.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 03.10.2023.
//

import SwiftUI

struct NavigationClearButton: View {
    @ObservedObject private var viewModel: SurebetCalculatorViewModel
    
    init(_ viewModel: SurebetCalculatorViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Button {
            viewModel.clearNavigationButton()
        } label: {
            Image(systemName: "trash")
        }
    }
}

struct NavigationClearButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationClearButton(SurebetCalculatorViewModel())
    }
}
