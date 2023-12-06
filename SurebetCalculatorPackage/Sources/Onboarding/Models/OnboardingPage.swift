//
//  OnboardingPage.swift
//
//
//  Created by Iaroslav Beldin on 03.10.2023.
//

import Foundation

struct OnboardingPage {
    let image: String
    let description: String
    
    static func createPages() -> [OnboardingPage] {
        [
            OnboardingPage(image: "onboarding1", description: "Calculate two outcomes"),
            OnboardingPage(image: "onboarding2", description: "Calculate three outcomes"),
            OnboardingPage(image: "onboarding3", description: "Calculate four outcomes")
        ]
    }
}
