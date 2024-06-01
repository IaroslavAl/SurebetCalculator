//
//  BetCalculatorTests.swift
//  SureBetProfitCalculatorTests
//
//  Created by Iaroslav Beldin on 01.06.2024.
//

@testable import SureBet_Profit_Calculator
import XCTest

final class BetCalculatorTests: XCTestCase {
    func testTotalCalculation() {
        // Given
        let calculator = BetCalculator(
            total: TotalRow(betSize: "1000", profitPercentage: ""),
            rows: [
                Row(id: 0, betSize: "", coefficient: "2", income: ""),
                Row(id: 1, betSize: "", coefficient: "3", income: "")
            ],
            selectedRow: .total,
            displayedRowIndexes: 0..<2
        )

        // When
        let result = calculator.calculate()

        // Then
        XCTAssertEqual(result.total?.betSize, "1000")
        XCTAssertEqual(result.total?.profitPercentage, "20%")
        XCTAssertEqual(result.rows?[0].income, "200")
        XCTAssertEqual(result.rows?[0].betSize, "600")
        XCTAssertEqual(result.rows?[1].income, "200")
        XCTAssertEqual(result.rows?[1].betSize, "400")
    }

    func testRowCalculation() {
        // Given
        let calculator = BetCalculator(
            total: TotalRow(betSize: "", profitPercentage: ""),
            rows: [
                Row(id: 0, betSize: "500", coefficient: "2", income: ""),
                Row(id: 1, betSize: "", coefficient: "3", income: "")
            ],
            selectedRow: .row(0),
            displayedRowIndexes: 0..<2
        )

        // When
        let result = calculator.calculate()

        // Then
        XCTAssertEqual(result.total?.betSize, "833,33")
        XCTAssertEqual(result.total?.profitPercentage, "20%")
        XCTAssertEqual(result.rows?[0].income, "166,67")
        XCTAssertEqual(result.rows?[1].income, "166,67")
        XCTAssertEqual(result.rows?[1].betSize, "333,33")
    }

    func testNoneCalculation() {
        // Given
        let calculator = BetCalculator(
            total: TotalRow(betSize: "", profitPercentage: ""),
            rows: [
                Row(id: 0, betSize: "", coefficient: "2", income: ""),
                Row(id: 1, betSize: "", coefficient: "3", income: "")
            ],
            selectedRow: .none,
            displayedRowIndexes: 0..<2
        )

        // When
        let result = calculator.calculate()

        // Then
        XCTAssertNil(result.total)
        XCTAssertNil(result.rows)
    }

    func testInvalidCoefficient() {
        // Given
        let calculator = BetCalculator(
            total: TotalRow(betSize: "", profitPercentage: ""),
            rows: [
                Row(id: 0, betSize: "100", coefficient: "", income: ""),
                Row(id: 1, betSize: "200", coefficient: "3", income: "")
            ],
            selectedRow: .none,
            displayedRowIndexes: 0..<2
        )

        // When
        let result = calculator.calculate()

        // Then
        XCTAssertNil(result.total)
        XCTAssertNil(result.rows)
    }

    func testProfitPercentageCalculationWithMultipleRows() {
        // Given
        let calculator = BetCalculator(
            total: TotalRow(betSize: "1000", profitPercentage: ""),
            rows: [
                Row(id: 0, betSize: "300", coefficient: "2", income: ""),
                Row(id: 1, betSize: "700", coefficient: "4", income: "")
            ],
            selectedRow: .none,
            displayedRowIndexes: 0..<2
        )

        // When
        let result = calculator.calculate()

        // Then
        XCTAssertEqual(result.total?.profitPercentage, "33,33%")
        XCTAssertEqual(result.rows?[0].income, "-400")
        XCTAssertEqual(result.rows?[1].income, "1800")
    }

    func testTotalCalculationWithThreeRows() {
        // Given
        let calculator = BetCalculator(
            total: TotalRow(betSize: "1000", profitPercentage: ""),
            rows: [
                Row(id: 0, betSize: "", coefficient: "2", income: ""),
                Row(id: 1, betSize: "", coefficient: "3", income: ""),
                Row(id: 2, betSize: "", coefficient: "4", income: "")
            ],
            selectedRow: .total,
            displayedRowIndexes: 0..<3
        )

        // When
        let result = calculator.calculate()

        // Then
        XCTAssertEqual(result.total?.betSize, "1000")
        XCTAssertEqual(result.total?.profitPercentage, "-7,69%")
        XCTAssertEqual(result.rows?[0].income, "-76,92")
        XCTAssertEqual(result.rows?[0].betSize, "461,54")
        XCTAssertEqual(result.rows?[1].income, "-76,92")
        XCTAssertEqual(result.rows?[1].betSize, "307,69")
        XCTAssertEqual(result.rows?[2].income, "-76,92")
        XCTAssertEqual(result.rows?[2].betSize, "230,77")
    }

    func testTotalCalculationWithFourRows() {
        // Given
        let calculator = BetCalculator(
            total: TotalRow(betSize: "1000", profitPercentage: ""),
            rows: [
                Row(id: 0, betSize: "", coefficient: "2", income: ""),
                Row(id: 1, betSize: "", coefficient: "3", income: ""),
                Row(id: 2, betSize: "", coefficient: "4", income: ""),
                Row(id: 3, betSize: "", coefficient: "5", income: "")
            ],
            selectedRow: .total,
            displayedRowIndexes: 0..<4
        )

        // When
        let result = calculator.calculate()

        // Then
        XCTAssertEqual(result.total?.betSize, "1000")
        XCTAssertEqual(result.total?.profitPercentage, "-22,08%")
        XCTAssertEqual(result.rows?[0].income, "-220,78")
        XCTAssertEqual(result.rows?[0].betSize, "389,61")
        XCTAssertEqual(result.rows?[1].income, "-220,78")
        XCTAssertEqual(result.rows?[1].betSize, "259,74")
        XCTAssertEqual(result.rows?[2].income, "-220,78")
        XCTAssertEqual(result.rows?[2].betSize, "194,81")
        XCTAssertEqual(result.rows?[3].income, "-220,78")
        XCTAssertEqual(result.rows?[3].betSize, "155,84")
    }
}
