//
//  OnboardingPage.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 03.10.2023.
//

import SwiftUI

struct OnboardingPage: Identifiable {
    let image: String
    let description: String

    static func createPages() -> [OnboardingPage] {
        [
            .init(image: image1, description: description1),
            .init(image: image2, description: description2),
            .init(image: image3, description: description3)
        ]
    }

    var id: String { image }
}

private extension OnboardingPage {
    static var iPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    static var image1: String { iPad ? "iPad1" : "iPhone1" }
    static var image2: String { iPad ? "iPad2" : "iPhone2" }
    static var image3: String { iPad ? "iPad3" : "iPhone3" }
    static var description1: String {
        "Calculate by inputting the total bet amount and coefficients for all outcomes."
    }
    static var description2: String {
        "Input the bet size for a single outcome and coefficients for all outcomes to calculate."
    }
    static var description3: String {
        "Enter the bet amount and coefficients for all outcomes after deactivating all switches."
    }
}
