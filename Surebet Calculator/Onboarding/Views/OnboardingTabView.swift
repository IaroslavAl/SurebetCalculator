//
//  OnboardingTabView.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 03.10.2023.
//

import SwiftUI

struct OnboardingTabView: View {
    @ObservedObject private var viewModel: OnboardingViewModel
    
    init(_ viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        TabView(selection: $viewModel.currentPage) {
            ForEach(viewModel.pages.indices, id: \.self) { index in
                OnboardingPageView(page: viewModel.pages[index])
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .animation(.default, value: viewModel.currentPage)
        .transition(.move(edge: .trailing))
    }
}

struct OnboardingTabView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingTabView(OnboardingViewModel())
    }
}
