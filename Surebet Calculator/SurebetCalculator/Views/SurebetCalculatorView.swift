//
//  SurebetCalculatorView.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 02.04.2024.
//

import SwiftUI

struct SurebetCalculatorView: View {
    @EnvironmentObject private var viewModel: SurebetCalculatorViewModel
    
    var body: some View {
        VStack(spacing: spacing) {
            PickerView()
            ScrollView(showsIndicators: false) {
                VStack(spacing: spacing) {
                    TotalRowView()
                        .padding(.trailing, horizontalPadding)
                    rowsView
                }
            }
            .simultaneousGesture(
                TapGesture().onEnded {
                    viewModel.send(.hideKeyboard)
                }
            )
        }
        .environmentObject(viewModel)
        .navigationTitle(navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: toolbar)
        .frame(maxHeight: .infinity, alignment: .top)
        .font(font)
    }
}

private extension SurebetCalculatorView {
    var rowsView: some View {
        VStack(spacing: rowsSpacing) {
            ForEach(viewModel.indexesOfDisplayedRows, id: \.self) { id in
                RowView(id: id)
            }
            .transition(.move(edge: .leading))
            .animation(.default, value: viewModel.selectedNumberOfRows)
        }
        .padding(.trailing, horizontalPadding)
    }
    
    @ToolbarContentBuilder
    func toolbar() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            NavigationClearButton()
        }
        ToolbarItemGroup(placement: .keyboard) {
            KeyboardClearButton()
            Spacer()
            KeyboardDoneButton()
        }
    }
}

private extension SurebetCalculatorView {
    var navigationTitle: String { "Surebet calculator" }
    var spacing: CGFloat { UIDevice.current.userInterfaceIdiom == .pad ? 24 : 16 }
    var rowsSpacing: CGFloat { UIDevice.current.userInterfaceIdiom == .pad ? 12 : 8 }
    var horizontalPadding: CGFloat { UIDevice.current.userInterfaceIdiom == .pad ? 12 : 8 }
    var font: Font { UIDevice.current.userInterfaceIdiom == .pad ? .title : .body }
}

#Preview {
    SurebetCalculatorView()
        .environmentObject(SurebetCalculatorViewModel())
}
