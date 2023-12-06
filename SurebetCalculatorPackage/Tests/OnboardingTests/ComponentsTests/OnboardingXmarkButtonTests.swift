//
//  OnboardingXmarkButtonTests.swift
//
//
//  Created by Iaroslav Beldin on 20.11.2023.
//

@testable import Onboarding
import SwiftUI
import XCTest

final class OnboardingXmarkButtonTests: XCTestCase {
    var onboardingIsDone: Bool!
    var onboardingXmarkButton: OnboardingXmarkButton!
    
    override func setUp() {
        super.setUp()
        onboardingIsDone = false
        let binding = Binding<Bool>(
            get: { self.onboardingIsDone },
            set: { self.onboardingIsDone = $0 }
        )
        onboardingXmarkButton = OnboardingXmarkButton(binding)
    }

    override func tearDown() {
        onboardingIsDone = nil
        onboardingXmarkButton = nil
        super.tearDown()
    }
    
    func testAction_SetOnboardingIsDone() {
        // When
        onboardingXmarkButton.action()
        
        // Then
        XCTAssertTrue(onboardingIsDone, "Expected onboardingIsDone to be true")
    }
}
