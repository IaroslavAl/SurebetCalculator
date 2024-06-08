@testable import Onboarding
import XCTest

final class OnboardingViewModelTests: XCTestCase {
    func testSetCurrentPage() {
        // Given
        let viewModel = OnboardingViewModel()

        // When
        viewModel.send(.setCurrentPage(1))

        // Then
        XCTAssertEqual(viewModel.currentPage, 1)
    }

    func testSetCurrentPageWhenCurrentPageIsOutOfRange() {
        // Given
        let viewModel = OnboardingViewModel()

        // When
        viewModel.send(.setCurrentPage(100))

        // Then
        XCTAssertEqual(viewModel.currentPage, 0)
        XCTAssert(viewModel.onboardingIsShown)
    }

    func testDismiss() {
        // Given
        let viewModel = OnboardingViewModel()

        // When
        viewModel.send(.dismiss)

        // Then
        XCTAssert(viewModel.onboardingIsShown)
    }
}
