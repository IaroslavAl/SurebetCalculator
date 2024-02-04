//
//  SurebetCalculatorView.swift
//  SureBetProfitCalculator
//
//  Created by BELDIN Yaroslav on 03.02.2024.
//

import SwiftUI

struct SurebetCalculatorView: View {
    @StateObject private var viewModel = SurebetCalculatorViewModel()
    @FocusState private var isFocused
    
    var body: some View {
        VStack(spacing: spacing) {
            PickerView(selection: $viewModel.numberOfOutcomes)
            Group {
                TotalView(
                    generalOutcome: $viewModel.total,
                    toggleAction: {
                        viewModel.select(row: .total)
                    }
                )
                rows
            }
            .focused($isFocused)
            .padding(.horizontal, horizontalPadding)
        }
        .navigationTitle(navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxHeight: .infinity, alignment: .top)
        .background(background)
        .font(font)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationClearButton(action: {})
            }
            ToolbarItemGroup(placement: .keyboard) {
                KeyboardDoneButton(action: hideKeyboard)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
}

private extension SurebetCalculatorView {
    var navigationTitle: String { "Surebet calculator" }
    var generalOutcomeIsOn: Bool { viewModel.selectedRow == .total }
    var spacing: CGFloat { 
        UIDevice.current.userInterfaceIdiom == .pad ? 32 : 16
    }
    var rowsSpacing: CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 16 : 8
    }
    var horizontalPadding: CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 16 : 8
    }
    var font: Font {
        UIDevice.current.userInterfaceIdiom == .pad ? .title : .body
    }
    
    var rows: some View {
        VStack(spacing: rowsSpacing) {
            ForEach(0..<viewModel.numberOfOutcomes.rawValue, id: \.self) { index in
                OutcomeView(
                    row: $viewModel.rows[index],
                    toggleAction: {
                        viewModel.select(row: .row(number: index))
                    }
                )
            }
            .transition(.move(edge: .leading))
            .animation(.default, value: viewModel.numberOfOutcomes)
        }
    }
    
    var background: some View {
        Color.clear
            .contentShape(.rect)
            .simultaneousGesture(
                TapGesture()
                    .onEnded(hideKeyboard)
            )
    }
    
    func hideKeyboard() {
        isFocused = false
    }
}

#Preview {
    SurebetCalculatorView()
}
