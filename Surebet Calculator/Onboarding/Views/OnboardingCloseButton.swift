//
//  OnboardingCloseButton.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 03.10.2023.
//

import SwiftUI

struct OnboardingCloseButton: View {
    @Binding private var onboardingIsDone: Bool
    
    init(_ onboardingIsDone: Binding<Bool>) {
        self._onboardingIsDone = onboardingIsDone
    }
    
    var body: some View {
        Button {
            onboardingIsDone = true
        } label: {
            Image(systemName: "xmark")
                .font(.title)
                .foregroundColor(Color(uiColor: .darkGray))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct OnboardingCloseButton_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCloseButton(.constant(false))
    }
}
