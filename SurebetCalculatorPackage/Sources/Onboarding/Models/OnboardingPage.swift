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
            .init(image: "onboarding1", description: "Calculate two outcomes"),
            .init(image: "onboarding2", description: "Calculate three outcomes"),
            .init(image: "onboarding3", description: "Calculate four outcomes")
        ]
    }
}
