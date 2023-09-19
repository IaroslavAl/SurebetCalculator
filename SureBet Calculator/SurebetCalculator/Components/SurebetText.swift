//
//  SurebetText.swift
//  SureBet Profit Calculator
//
//  Created by BELDIN Yaroslav on 03.10.2023.
//

import SwiftUI

struct SurebetText: View {
    let number: Double
    let isPercent: Bool
    
    init(
        number: Double,
        isPercent: Bool = false
    ) {
        self.number = number
        self.isPercent = isPercent
    }
    
    var body: some View {
        Text(number.formatToString(isPercent: isPercent))
            .padding(8)
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(Color(uiColor: .secondarySystemFill))
            .cornerRadius(10)
            .foregroundColor(number >= 0 ? .green : .red)
    }
}

struct SurebetCalculatorText_Previews: PreviewProvider {
    static var previews: some View {
        SurebetText(number: 1000, isPercent: true)
            .padding()
    }
}
