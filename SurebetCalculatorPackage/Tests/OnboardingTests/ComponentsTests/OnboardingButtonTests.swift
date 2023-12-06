//
//  OnboardingButtonTests.swift
//
//
//  Created by Iaroslav Beldin on 20.11.2023.
//

@testable import Onboarding
import SwiftUI
import XCTest

final class OnboardingButtonTests: XCTestCase {
    var viewModel: OnboardingViewModel!
    var onboardingIsDone: Bool!
    var onboardingButton: OnboardingButton!
    
    override func setUp() {
        super.setUp()
        viewModel = OnboardingViewModel()
        onboardingIsDone = false
        let binding = Binding<Bool>(
            get: { self.onboardingIsDone },
            set: { self.onboardingIsDone = $0 }
        )
        onboardingButton = OnboardingButton(
            viewModel,
            onboardingIsDone: binding
        )
    }

    override func tearDown() {
        viewModel = nil
        onboardingIsDone = nil
        onboardingButton = nil
        super.tearDown()
    }
    
    func testAction_SetOnboardingIsDone() {
        // When
        viewModel.currentPage = viewModel.pages.index(before: viewModel.pages.endIndex)
        onboardingButton.action()
        
        // Then
        XCTAssertEqual(viewModel.currentPage, viewModel.pages.index(before: viewModel.pages.endIndex), "Expected currentPage to not change")
        XCTAssertTrue(onboardingIsDone, "Expected onboardingIsDone to be true")
    }
}
