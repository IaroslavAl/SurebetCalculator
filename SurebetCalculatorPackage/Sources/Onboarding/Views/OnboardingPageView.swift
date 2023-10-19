//
//  OnboardingPageView.swift
//
//
//  Created by Iaroslav Beldin on 03.10.2023.
//

import SwiftUI

struct OnboardingPageView: View {
    private let page: OnboardingPage
    
    init(page: OnboardingPage) {
        self.page = page
    }
    
    var body: some View {
        VStack {
            Image(page.image)
                .resizable()
                .scaledToFit()
                .padding(.vertical)
            Text(page.description)
                .font(.title)
        }
    }
}

struct OnboardingPageView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPageView(page: .init(image: "onboarding", description: "Page 1"))
    }
}
