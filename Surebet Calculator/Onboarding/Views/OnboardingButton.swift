//
//  OnboardingButton.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 03.10.2023.
//

import SwiftUI

struct OnboardingButton: View {
    @EnvironmentObject private var vm: OnboardingViewModel
    
    var body: some View {
        Button(action: action) {
            label
        }
    }
}

private extension OnboardingButton {
    var text: String {
        let firstPage = 0
        let lastPage = vm.pages.index(before: vm.pages.endIndex)
        if vm.currentPage == firstPage {
            return "More details"
        } else if vm.currentPage == lastPage {
            return "Close"
        } else {
            return "Next"
        }
    }
    var iPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    var cornerRadius: CGFloat { iPad ? 18 : 12 }
    
    func action() {
        vm.send(.setCurrentPage(vm.currentPage + 1))
    }
    
    var label: some View {
        Text(text)
            .foregroundColor(.white)
            .bold()
            .frame(maxWidth: .infinity)
            .padding()
            .background(.green)
            .cornerRadius(cornerRadius)
            .animation(.none, value: vm.currentPage)
    }
}

#Preview {
    OnboardingButton()
        .environmentObject(OnboardingViewModel())
}

