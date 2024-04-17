//
//  OnboardingTabView.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 03.10.2023.
//

import SwiftUI

struct OnboardingTabView: View {
    @EnvironmentObject private var vm: OnboardingViewModel
    
    var body: some View {
        TabView(selection: selection) {
            ForEach(vm.pages.indices, id: \.self) { index in
                OnboardingPageView(page: vm.pages[index])
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .animation(.default, value: vm.currentPage)
        .transition(.move(edge: .trailing))
    }
}

private extension OnboardingTabView {
    var selection: Binding<Int> {
        .init(
            get: { vm.currentPage },
            set: { vm.send(.setCurrentPage($0)) }
        )
    }
}

#Preview {
    OnboardingTabView()
        .environmentObject(OnboardingViewModel())
}
