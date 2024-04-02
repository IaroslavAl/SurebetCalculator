//
//  TextView.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 02.04.2024.
//

import SwiftUI

struct TextView: View {
    let number: Double
    let isPercent: Bool
    
    var body: some View {
        Text(number.formatToString(isPercent: isPercent))
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
    var frameHeight: CGFloat { UIDevice.current.userInterfaceIdiom == .pad ? 80 : 40 }
    var cornerRadius: CGFloat { 10 }
    var color: Color { isNumberNotNegative(number) ? .green : .red }
    
    func isNumberNotNegative(_ number: Double) -> Bool {
        number >= 0
    }
}

#Preview {
    TextView(number: 1, isPercent: true)
        .padding()
}
