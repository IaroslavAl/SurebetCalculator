//
//  OnboardingButton.swift
//
//
//  Created by Iaroslav Beldin on 03.10.2023.
//

import SwiftUI

struct OnboardingButton: View {
    @ObservedObject private var viewModel: OnboardingViewModel
    @Binding private var onboardingIsDone: Bool
    
    init(
        _ viewModel: OnboardingViewModel,
        onboardingIsDone: Binding<Bool>
    ) {
        self.viewModel = viewModel
        self._onboardingIsDone = onboardingIsDone
    }
    
    var body: some View {
        Button(action: action) {
            label
        }
    }
    
    func action() -> Void {
        if viewModel.currentPage < viewModel.pages.index(before: viewModel.pages.endIndex) {
            viewModel.currentPage += 1
        } else {
            onboardingIsDone = true
        }
    }
}

private extension OnboardingButton {
    var label: some View {
        Text(
            viewModel.currentPage == 0
                ? "More details"
                : viewModel.currentPage < viewModel.pages.count - 1
                    ? "Next"
                    : "Close"
        )
        .foregroundColor(.white)
        .bold()
        .frame(maxWidth: .infinity)
        .padding()
        .background(.green)
        .cornerRadius(12)
        .transaction { $0.animation = .none }
    }
}

struct OnboardingButton_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingButton(OnboardingViewModel(), onboardingIsDone: .constant(false))
    }
}
