//
//  CalculatorTextFieldStyle.swift
//  SureBetProfitCalculator
//
//  Created by BELDIN Yaroslav on 03.02.2024.
//

import SwiftUI

struct CalculatorTextFieldStyle: TextFieldStyle {
    let isValid: Bool
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .multilineTextAlignment(.center)
            .padding(padding)
            .frame(height: frameHeight)
            .background(Color(uiColor: .secondarySystemFill))
            .cornerRadius(cornerRadius)
            .keyboardType(.decimalPad)
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(strokeColor, lineWidth: strokeLineWidth)
                    .animation(.default, value: isValid)
            }
    }
}

private extension CalculatorTextFieldStyle {
    var padding: CGFloat { 8 }
    var frameHeight: CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 80 : 40
    }
    var cornerRadius: CGFloat { 10 }
    var strokeColor: Color { isValid ? Color.clear : .red }
    var strokeLineWidth: CGFloat { 1.5 }
}

extension TextFieldStyle where Self == CalculatorTextFieldStyle {
    static func calculatorStyle(_ isValid: Bool) -> CalculatorTextFieldStyle {
        CalculatorTextFieldStyle(isValid: isValid)
    }
}
