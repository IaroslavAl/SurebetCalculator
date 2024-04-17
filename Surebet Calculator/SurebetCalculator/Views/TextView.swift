//
//  TextView.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 02.04.2024.
//

import SwiftUI

struct TextView: View {
    let text: String
    let isPercent: Bool
    
    var body: some View {
        Text(text)
            .padding(textPadding)
            .frame(height: frameHeight)
            .frame(maxWidth: .infinity)
            .background(Color(uiColor: .secondarySystemFill))
            .cornerRadius(cornerRadius)
            .foregroundColor(color)
    }
}

private extension TextView {
    var textPadding: CGFloat { 8 }
    var frameHeight: CGFloat { UIDevice.current.userInterfaceIdiom == .pad ? 60 : 40 }
    var cornerRadius: CGFloat { UIDevice.current.userInterfaceIdiom == .pad ? 15 : 10 }
    var color: Color { isNumberNotNegative(text) ? .green : .red }
    
    func isNumberNotNegative(_ text: String) -> Bool {
        if let text = text.formatToDouble() {
            return text >= 0
        } else {
            return true
        }
    }
}

#Preview {
    TextView(text: 1.formatToString(isPercent: true), isPercent: true)
        .padding()
}
