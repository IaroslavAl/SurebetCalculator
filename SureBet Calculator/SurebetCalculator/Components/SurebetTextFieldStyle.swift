//
//  SurebetTextFieldStyle.swift
//  SureBet Profit Calculator
//
//  Created by BELDIN Yaroslav on 03.10.2023.
//

import SwiftUI

struct SurebetTextFieldStyle: TextFieldStyle {
    @Binding var isValid: Bool
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .multilineTextAlignment(.center)
            .padding(8)
            .frame(height: 40)
            .background(Color(uiColor: .secondarySystemFill))
            .cornerRadius(10)
            .keyboardType(.decimalPad)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        isValid ? Color.clear : .red,
                        lineWidth: 1.5
                    )
                    .animation(.default, value: isValid)
            }
    }
}

extension TextFieldStyle where Self == SurebetTextFieldStyle {
    static func surebet(_ isValid: Binding<Bool>) -> SurebetTextFieldStyle {
        SurebetTextFieldStyle(isValid: isValid)
    }
}
