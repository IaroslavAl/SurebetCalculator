//
//  ToggleButton.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 02.04.2024.
//

import SwiftUI

struct ToggleButton: View {
    @EnvironmentObject private var viewModel: SurebetCalculatorViewModel

    let row: RowType

    var body: some View {
        Button(action: actionWithImpactFeedback, label: label)
            .animation(.easeInOut(duration: animationDuration), value: isON)
    }
}

private extension ToggleButton {
    var isON: Bool {
        switch row {
        case .total:
            return viewModel.total.isON
        case let .row(id):
            if let row = viewModel.rows.first(where: { $0.id == id }) {
                return row.isON
            }
            return false
        }
    }
    var iPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    var height: CGFloat { iPad ? 60 : 40 }
    var horizontalPadding: CGFloat { iPad ? 12 : 8 }
    var transition: AnyTransition { .opacity.combined(with: .scale) }
    var animationDuration: Double { 0.25 }

    func label() -> some View {
        if isON {
            Image(systemName: "soccerball")
                .frame(height: height)
                .foregroundColor(.green)
                .padding(.horizontal, horizontalPadding)
                .transition(transition)
        } else {
            Image(systemName: "circle")
                .frame(height: height)
                .foregroundColor(.red)
                .padding(.horizontal, horizontalPadding)
                .transition(transition)
        }
    }

    func actionWithImpactFeedback() {
        let impactFeedback = UIImpactFeedbackGenerator(style: .heavy)
        viewModel.send(.selectRow(row))
        impactFeedback.impactOccurred()
    }
}

#Preview {
    ToggleButton(row: .total)
}
