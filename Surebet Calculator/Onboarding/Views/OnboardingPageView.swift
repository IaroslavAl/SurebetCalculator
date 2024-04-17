//
//  OnboardingPageView.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 03.10.2023.
//

import SwiftUI

struct OnboardingPageView: View {
    let page: OnboardingPage
    
    var body: some View {
        VStack(spacing: .zero) {
            Image(page.image)
                .resizable()
                .scaledToFit()
                .padding(.vertical)
            Spacer()
            Text(page.description)
                .font(.title)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .minimumScaleFactor(0.5)
            Spacer()
        }
    }
}

#Preview {
    OnboardingPageView(
        page: .init(
            image: "onboarding1",
            description: "description"
        )
    )
}
