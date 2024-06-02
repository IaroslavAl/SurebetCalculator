//
//  OnboardingCloseButton.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 03.10.2023.
//

import SwiftUI

struct OnboardingCloseButton: View {
    @EnvironmentObject private var viewModel: OnboardingViewModel

    var body: some View {
        Button(action: action) {
            label
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private extension OnboardingCloseButton {
    var imageName: String { "xmark" }

    func action() {
        viewModel.send(.dismiss)
    }

    var label: some View {
        Image(systemName: imageName)
            .font(.title)
            .foregroundColor(
                Color(uiColor: .darkGray)
            )
    }
}

#Preview {
    OnboardingCloseButton()
}
