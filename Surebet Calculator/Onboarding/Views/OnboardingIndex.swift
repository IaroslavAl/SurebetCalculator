//
//  OnboardingIndex.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 03.10.2023.
//

import SwiftUI

struct OnboardingIndex: View {
    @EnvironmentObject private var vm: OnboardingViewModel
    
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(vm.pages.indices, id: \.self) { index in
                Circle()
                    .frame(width: size(index))
                    .foregroundColor(color(index))
            }
        }
        .animation(.default, value: vm.currentPage)
        .padding(padding)
        .fixedSize()
    }
}

private extension OnboardingIndex {
    var iPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    var spacing: CGFloat { iPad ? 12 : 8 }
    var padding: CGFloat { iPad ? 36 : 24 }
    
    func size(_ index: Int) -> CGFloat {
        if index == vm.currentPage {
            iPad ? 18 : 12
        } else {
            iPad ? 12 : 8
        }
    }
    
    func color(_ index: Int) -> Color {
        Color(uiColor: index == vm.currentPage ? .darkGray : .lightGray)
    }
}

#Preview {
    OnboardingIndex()
        .environmentObject(OnboardingViewModel())
}
