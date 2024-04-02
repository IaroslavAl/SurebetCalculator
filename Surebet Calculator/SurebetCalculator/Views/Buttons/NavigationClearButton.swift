//
//  NavigationClearButton.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 02.04.2024.
//

import SwiftUI

struct NavigationClearButton: View {
    @EnvironmentObject private var viewModel: SurebetCalculatorViewModel
    
    var body: some View {
        Button {
            viewModel.send(.clearAll)
        } label: {
            Image(systemName: "trash")
        }
    }
}

#Preview {
    NavigationClearButton()
        .environmentObject(SurebetCalculatorViewModel())
}
