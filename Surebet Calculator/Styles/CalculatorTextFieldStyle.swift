//
//  CalculatorTextFieldStyle.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 02.04.2024.
//

import SwiftUI

struct CalculatorTextFieldStyle: TextFieldStyle {
    let isEnabled: Bool
    let isValid: Bool

    // swiftlint:disable:next identifier_name
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .multilineTextAlignment(.center)
            .padding(padding)
            .frame(height: frameHeight)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .keyboardType(.decimalPad)
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(strokeColor, lineWidth: strokeLineWidth)
            }
            .animation(.default, value: isValid)
            .animation(.default, value: isEnabled)
    }
}

private extension CalculatorTextFieldStyle {
    var padding: CGFloat { 8 }
    var iPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    var frameHeight: CGFloat { iPad ? 60 : 40 }
    var cornerRadius: CGFloat { iPad ? 15 : 10 }
    var strokeLineWidth: CGFloat { iPad ? 1.5 : 1 }
    var strokeColor: Color { isEnabled ? .green : .clear }
    var backgroundColor: Color {
        isValid ? Color(uiColor: .secondarySystemFill) : .red.opacity(0.3)
    }
}

extension TextFieldStyle where Self == CalculatorTextFieldStyle {
    static func calculatorStyle(
        isEnabled: Bool,
        isValid: Bool
    ) -> CalculatorTextFieldStyle {
        CalculatorTextFieldStyle(isEnabled: isEnabled, isValid: isValid)
    }
}
