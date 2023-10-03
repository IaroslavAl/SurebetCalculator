//
//  SurebetCalculatorView.swift
//  SureBet Calculator
//
//  Created by Iaroslav Beldin on 21.01.2023.
//

import SwiftUI

struct SurebetCalculatorView: View {
    @StateObject private var viewModel = SurebetCalculatorViewModel()
    @FocusState private var isFocused: Focusable?
    
    var body: some View {
        VStack(spacing: 16) {
            SurebetPicker(viewModel)
            SurebetGeneralOutcome(viewModel)
            SurebetOutcomes(viewModel)
            Spacer()
        }
        .background(
            Color(uiColor: .systemBackground)
                .onTapGesture {
                    viewModel.isFocused = .none
                }
        )
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationClearButton(viewModel)
            }
            ToolbarItemGroup(placement: .keyboard) {
                KeyboardClearButton(viewModel)
                Spacer()
                KeyboardDoneButton(viewModel)
            }
        }
        .onChange(of: isFocused) {
            viewModel.isFocused = $0
            viewModel.turnOffBlock(isFocused: $0)
        }
        .onChange(of: viewModel.isFocused) {
            isFocused = $0
        }
        .navigationTitle("Surebet calculator")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SurebetCalculator_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SurebetCalculatorView()
        }
    }
}
