//
//  KeyboardDoneButton.swift
//  SureBetProfitCalculator
//
//  Created by BELDIN Yaroslav on 04.02.2024.
//

import SwiftUI

struct KeyboardDoneButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(text, action: action)
    }
}

private extension KeyboardDoneButton {
    var text: String { "Done" }
}

#Preview {
    KeyboardDoneButton(action: {})
}
