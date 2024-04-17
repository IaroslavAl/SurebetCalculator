//
//  OnboardingViewModelTests.swift
//  SureBetProfitCalculatorTests
//
//  Created by Iaroslav Beldin on 18.04.2024.
//

import XCTest
@testable import SureBet_Profit_Calculator

final class OnboardingViewModelTests: XCTestCase {
    
    func testSetCurrentPage() {
        // Given
        let vm = OnboardingViewModel()
        
        // When
        vm.send(.setCurrentPage(1))
        
        // Then
        XCTAssertEqual(vm.currentPage, 1)
    }
    
    func testSetCurrentPageWhenCurrentPageIsOutOfRange() {
        // Given
        let vm = OnboardingViewModel()
        
        // When
        vm.send(.setCurrentPage(100))
        
        // Then
        XCTAssertEqual(vm.currentPage, 0)
        XCTAssert(vm.onboardingIsShown)
    }
    
    func testDismiss() {
        // Given
        let vm = OnboardingViewModel()
        
        // When
        vm.send(.dismiss)
        
        // Then
        XCTAssert(vm.onboardingIsShown)
    }
}
