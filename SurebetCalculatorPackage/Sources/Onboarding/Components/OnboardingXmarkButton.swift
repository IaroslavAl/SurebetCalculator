//
//  OnboardingCloseButton.swift
//
//
//  Created by Iaroslav Beldin on 03.10.2023.
//

import SwiftUI

struct OnboardingXmarkButton: View {
    @Binding private var onboardingIsDone: Bool
    
    init(_ onboardingIsDone: Binding<Bool>) {
        self._onboardingIsDone = onboardingIsDone
    }
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "xmark")
                .font(.title)
                .foregroundColor(Color(uiColor: .darkGray))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func action() -> Void {
        onboardingIsDone = true
    }
}

struct OnboardingCloseButton_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingXmarkButton(.constant(false))
    }
}
