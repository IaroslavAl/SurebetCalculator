//
//  OnboardingView.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 03.10.2023.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject private var viewModel: OnboardingViewModel
    @Binding var onboardingIsShown: Bool

    var body: some View {
        VStack(spacing: .zero) {
            OnboardingCloseButton()
            OnboardingTabView()
            OnboardingIndex()
            OnboardingButton()
        }
        .padding()
        .onChange(of: viewModel.onboardingIsShown) {
            onboardingIsShown = $0
        }
    }
}

#Preview {
    OnboardingView(onboardingIsShown: .constant(false))
}
