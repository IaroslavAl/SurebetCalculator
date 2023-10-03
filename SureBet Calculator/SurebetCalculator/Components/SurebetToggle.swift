//
//  SurebetToggle.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 03.10.2023.
//

import SwiftUI

struct SurebetToggle: View {
    @ObservedObject private var viewModel: SurebetCalculatorViewModel
    private let isOn: Bool
    private let action: () -> Void
    
    init(
        viewModel: SurebetCalculatorViewModel,
        isOn: Bool,
        action: @escaping () -> Void
    ) {
        self.viewModel = viewModel
        self.isOn = isOn
        self.action = action
    }
    
    var body: some View {
        Button {
            viewModel.isFocused = .none
            viewModel.isBlock = true
            action()
        } label: {
            Image(systemName: isOn ? "soccerball" : "circle")
                .frame(height: 40)
                .foregroundColor(isOn ? .green : .red)
                .padding(.leading)
                .padding(.trailing, 8)
        }
    }
}

struct SurebetToggle_Previews: PreviewProvider {
    static var previews: some View {
        SurebetToggle(viewModel: SurebetCalculatorViewModel(), isOn: true, action: {})
    }
}
