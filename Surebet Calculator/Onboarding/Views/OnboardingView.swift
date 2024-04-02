//
//  OnboardingView.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 03.10.2023.
//

import SwiftUI

struct OnboardingView: View {
    @Binding private var onboardingIsDone: Bool
    @StateObject private var viewModel = OnboardingViewModel()
    
    init(_ onboardingIsDone: Binding<Bool>) {
        self._onboardingIsDone = onboardingIsDone
    }
    
    var body: some View {
        VStack {
            OnboardingCloseButton($onboardingIsDone)
            OnboardingTabView(viewModel)
            OnboardingIndex(viewModel)
            OnboardingButton(viewModel, onboardingIsDone: $onboardingIsDone)
        }
        .padding()
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(.constant(false))
    }
}
