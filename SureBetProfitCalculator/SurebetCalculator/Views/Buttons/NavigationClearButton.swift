//
//  NavigationClearButton.swift
//  SureBetProfitCalculator
//
//  Created by BELDIN Yaroslav on 04.02.2024.
//

import SwiftUI

struct NavigationClearButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "trash")
        }
    }
}

#Preview {
    NavigationClearButton(action: {})
}
