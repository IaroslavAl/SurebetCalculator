//
//  OnboardingIndex.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 03.10.2023.
//

import SwiftUI

struct OnboardingIndex: View {
    @ObservedObject private var viewModel: OnboardingViewModel
    
    init(_ viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            ForEach(viewModel.pages.indices, id: \.self) { index in
                let size: CGFloat = index == viewModel.currentPage
                ? 12
                : 8
                Circle()
                    .frame(width: size, height: size)
                    .foregroundColor(
                        index == viewModel.currentPage
                        ? Color(uiColor: .darkGray)
                        : Color(uiColor: .lightGray)
                    )
            }
        }
        .animation(.default, value: viewModel.currentPage)
        .padding(24)
    }
}

struct OnboardingIndex_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingIndex(OnboardingViewModel())
    }
}
