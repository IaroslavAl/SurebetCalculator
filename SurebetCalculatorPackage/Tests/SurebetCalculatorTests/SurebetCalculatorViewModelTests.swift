// swiftlint:disable file_length

@testable import SurebetCalculator
import XCTest

// swiftlint:disable:next type_body_length
final class SurebetCalculatorViewModelTests: XCTestCase {
    func testSelectRow() {
        // Given
        let viewModel = SurebetCalculatorViewModel()
        let id = 0
        let row: RowType = .row(id)

        // When
        viewModel.send(.selectRow(row))

        // Then
        XCTAssertFalse(viewModel.total.isON)
        XCTAssert(viewModel.rows[id].isON)
        XCTAssertEqual(viewModel.selectedRow, row)
    }

    func testSelectTotal() {
        // Given
        let viewModel = SurebetCalculatorViewModel(selectedRow: .none)
        let row: RowType = .total

        // When
        viewModel.send(.selectRow(row))

        // Then
        XCTAssert(viewModel.total.isON)
        XCTAssertEqual(viewModel.selectedRow, row)
    }

    func testSelectNone() {
        // Given
        let id = 0
        let viewModel = SurebetCalculatorViewModel(selectedRow: .row(id))
        let row: RowType = .row(id)

        // When
        viewModel.send(.selectRow(row))

        // Then
        XCTAssertFalse(viewModel.rows[id].isON)
        XCTAssertEqual(viewModel.selectedRow, .none)
    }

    func testSelectNumberOfRowsWhenToDeselectAndClear() {
        // Given
        let initialNumberOfRows: NumberOfRows = .three
        let newNumberOfRows: NumberOfRows = .two
        let id = 2
        let viewModel = SurebetCalculatorViewModel(
            rows: [
                .init(id: 0),
                .init(id: 1),
                .init(id: 2, isON: true, betSize: "777"),
                .init(id: 3)
            ],
            selectedNumberOfRows: initialNumberOfRows,
            selectedRow: .row(id)
        )

        // When
        viewModel.send(.selectNumberOfRows(newNumberOfRows))

        // Then
        XCTAssertFalse(viewModel.rows[id].isON)
        XCTAssertEqual(viewModel.rows[id].betSize, "")
        XCTAssertEqual(viewModel.selectedNumberOfRows, newNumberOfRows)
    }

    func testSetTotalBetSizeTextField() {
        // Given
        let viewModel = SurebetCalculatorViewModel(
            total: .init(betSize: "777"),
            rows: [
                .init(id: 0, betSize: "555"),
                .init(id: 1),
                .init(id: 2),
                .init(id: 3)
            ],
            selectedRow: .row(0)
        )
        let textField: FocusableField = .totalBetSize
        let text = ""

        // When
        viewModel.send(.setTextFieldText(textField, text))

        // Then
        XCTAssertEqual(viewModel.selectedRow, .total)
        XCTAssertEqual(viewModel.total.betSize, text)
        XCTAssertEqual(viewModel.rows[0].betSize, "")
    }

    func testSetRowBetSize() {
        // Given
        let viewModel = SurebetCalculatorViewModel(
            total: .init(isON: true, betSize: "777"),
            rows: [
                .init(id: 0),
                .init(id: 1, betSize: "777"),
                .init(id: 2),
                .init(id: 3)
            ]
        )
        let textField: FocusableField = .rowBetSize(0)
        let text = ""

        // When
        viewModel.send(.setTextFieldText(textField, text))

        // Then
        XCTAssertEqual(viewModel.rows[0].betSize, text)
        XCTAssertEqual(viewModel.rows[1].betSize, "")
        XCTAssertEqual(viewModel.total.betSize, "")
    }

    func testSetRowBetSizeWhenSelectedRowIsNone() {
        // Given
        let viewModel = SurebetCalculatorViewModel(selectedRow: .none)
        let textField: FocusableField = .rowBetSize(0)
        let text = "777"

        // When
        viewModel.send(.setTextFieldText(textField, text))

        // Then
        XCTAssertEqual(viewModel.rows[0].betSize, text)
        XCTAssertEqual(viewModel.total.betSize, "777")
    }

    func testSetRowBetSizeWhenSelectedRowIsNoneAndSumOfBetSizesEqualZero() {
        // Given
        let viewModel = SurebetCalculatorViewModel(selectedRow: .none)
        let textField: FocusableField = .rowBetSize(0)
        let text = ""

        // When
        viewModel.send(.setTextFieldText(textField, text))

        // Then
        XCTAssertEqual(viewModel.rows[0].betSize, text)
        XCTAssertEqual(viewModel.total.betSize, "")
    }

    func testSetRowCoefficient() {
        // Given
        let viewModel = SurebetCalculatorViewModel()
        let textField: FocusableField = .rowCoefficient(0)
        let text = ""

        // When
        viewModel.send(.setTextFieldText(textField, text))

        // Then
        XCTAssertEqual(viewModel.rows[0].coefficient, text)
    }

    func testSetFocus() {
        // Given
        let viewModel = SurebetCalculatorViewModel()
        let field: FocusableField = .totalBetSize

        // When
        viewModel.send(.setFocus(field))

        // Then
        XCTAssertEqual(viewModel.focus, field)
    }

    func testClearTotalBetSizeField() {
        // Given
        let viewModel = SurebetCalculatorViewModel(
            total: .init(betSize: "777"),
            focus: .totalBetSize
        )

        // When
        viewModel.send(.clearFocusableField)

        // Then
        XCTAssertEqual(viewModel.total.betSize, "")
    }

    func testClearRowBetSizeField() {
        // Given
        let viewModel = SurebetCalculatorViewModel(
            rows: [
                .init(id: 0, betSize: "777"),
                .init(id: 1),
                .init(id: 2),
                .init(id: 3)
            ],
            focus: .rowBetSize(0)
        )

        // When
        viewModel.send(.clearFocusableField)

        // Then
        XCTAssertEqual(viewModel.rows[0].betSize, "")
    }

    func testClearRowCoefficientField() {
        // Given
        let viewModel = SurebetCalculatorViewModel(
            rows: [
                .init(id: 0, coefficient: "777"),
                .init(id: 1),
                .init(id: 2),
                .init(id: 3)
            ],
            focus: .rowCoefficient(0)
        )

        // When
        viewModel.send(.clearFocusableField)

        // Then
        XCTAssertEqual(viewModel.rows[0].coefficient, "")
    }

    func testClearNoneField() {
        // Given
        let viewModel = SurebetCalculatorViewModel(focus: .none)

        // When
        viewModel.send(.clearFocusableField)

        // Then
    }

    func testClearAll() {
        // Given
        let viewModel = SurebetCalculatorViewModel(
            total: .init(betSize: "777", profitPercentage: "777%"),
            rows: [
                .init(id: 0, betSize: "777", coefficient: "777", income: "777"),
                .init(id: 1),
                .init(id: 2),
                .init(id: 3)
            ]
        )

        // When
        viewModel.send(.clearAll)

        // Then
        XCTAssertEqual(viewModel.total.betSize, "")
        XCTAssertEqual(viewModel.total.profitPercentage, "0%")
        XCTAssertEqual(viewModel.rows[0].betSize, "")
        XCTAssertEqual(viewModel.rows[0].coefficient, "")
        XCTAssertEqual(viewModel.rows[0].income, "0")
    }

    func testHideKeyboard() {
        // Given
        let viewModel = SurebetCalculatorViewModel(
            focus: .totalBetSize
        )

        // When
        viewModel.send(.hideKeyboard)

        // Then
        XCTAssertEqual(viewModel.focus, .none)
    }

    func testCalculationMethodWhenSelectedRowIsTotalAndSelectedNumberOfRowsIsTwo() {
        // Given
        let viewModel = SurebetCalculatorViewModel(
            rows: [
                .init(id: 0, coefficient: "2,22"),
                .init(id: 1, coefficient: "3,33"),
                .init(id: 2),
                .init(id: 3)
            ],
            selectedNumberOfRows: .two
        )

        // When
        viewModel.send(.setTextFieldText(.totalBetSize, "777"))

        // Then
        XCTAssertEqual(
            viewModel.total,
            TotalRow(
                isON: true,
                betSize: "777",
                profitPercentage: "33,2%"
            )
        )
        XCTAssertEqual(
            viewModel.rows[0],
            Row(
                id: 0,
                isON: false,
                betSize: "466,2",
                coefficient: "2,22",
                income: "257,96"
            )
        )
        XCTAssertEqual(
            viewModel.rows[1],
            Row(
                id: 1,
                isON: false,
                betSize: "310,8",
                coefficient: "3,33",
                income: "257,96"
            )
        )
        XCTAssertEqual(
            viewModel.rows[2],
            Row(id: 2)
        )
        XCTAssertEqual(
            viewModel.rows[3],
            Row(id: 3)
        )
    }

    // swiftlint:disable:next function_body_length
    func testCalculationMethodWhenSelectedRowIsRowAndSelectedNumberOfRowsIsThree() {
        // Given
        let viewModel = SurebetCalculatorViewModel(
            total: .init(isON: false),
            rows: [
                .init(id: 0, isON: true, coefficient: "2,22"),
                .init(id: 1, coefficient: "3,33"),
                .init(id: 2, coefficient: "4,44"),
                .init(id: 3)
            ],
            selectedNumberOfRows: .three,
            selectedRow: .row(0)
        )

        // When
        viewModel.send(.setTextFieldText(.rowBetSize(0), "777"))

        // Then
        XCTAssertEqual(
            viewModel.total,
            TotalRow(
                isON: false,
                betSize: "1683,5",
                profitPercentage: "2,46%"
            )
        )
        XCTAssertEqual(
            viewModel.rows[0],
            Row(
                id: 0,
                isON: true,
                betSize: "777",
                coefficient: "2,22",
                income: "41,44"
            )
        )
        XCTAssertEqual(
            viewModel.rows[1],
            Row(
                id: 1,
                isON: false,
                betSize: "518",
                coefficient: "3,33",
                income: "41,44"
            )
        )
        XCTAssertEqual(
            viewModel.rows[2],
            Row(
                id: 2,
                isON: false,
                betSize: "388,5",
                coefficient: "4,44",
                income: "41,44"
            )
        )
        XCTAssertEqual(
            viewModel.rows[3],
            Row(id: 3)
        )
    }

    // swiftlint:disable:next function_body_length
    func testCalculationMethodWhenSelectedRowIsNoneAndSelectedNumberOfRowsIsFour() {
        // Given
        let viewModel = SurebetCalculatorViewModel(
            total: .init(isON: false),
            rows: [
                .init(id: 0, betSize: "444", coefficient: "2,22"),
                .init(id: 1, betSize: "555", coefficient: "3,33"),
                .init(id: 2, betSize: "666", coefficient: "4,44"),
                .init(id: 3, coefficient: "5,55")
            ],
            selectedNumberOfRows: .four,
            selectedRow: .none
        )

        // When
        viewModel.send(.setTextFieldText(.rowBetSize(3), "777"))

        // Then
        XCTAssertEqual(
            viewModel.total,
            TotalRow(
                isON: false,
                betSize: "2442",
                profitPercentage: "-13,51%"
            )
        )
        XCTAssertEqual(
            viewModel.rows[0],
            Row(
                id: 0,
                isON: false,
                betSize: "444",
                coefficient: "2,22",
                income: "-1456,32"
            )
        )
        XCTAssertEqual(
            viewModel.rows[1],
            Row(
                id: 1,
                isON: false,
                betSize: "555",
                coefficient: "3,33",
                income: "-593,85"
            )
        )
        XCTAssertEqual(
            viewModel.rows[2],
            Row(
                id: 2,
                isON: false,
                betSize: "666",
                coefficient: "4,44",
                income: "515,04"
            )
        )
        XCTAssertEqual(
            viewModel.rows[3],
            Row(
                id: 3,
                isON: false,
                betSize: "777",
                coefficient: "5,55",
                income: "1870,35"
            )
        )
    }

    func testNoneCalculationMethod() {
        // Given
        let viewModel = SurebetCalculatorViewModel(
            rows: [
                .init(id: 0, coefficient: "2,22"),
                .init(id: 1, coefficient: "3,33"),
                .init(id: 2),
                .init(id: 3)
            ]
        )

        // When
        viewModel.send(.setTextFieldText(.totalBetSize, "xxx"))

        // Then
    }

    func testProfitPercentageDoesNotChangeForAllCoefficients() {
        // Given
        let viewModel = SurebetCalculatorViewModel(
            rows: [
                .init(id: 0, coefficient: "2,22"),
                .init(id: 1),
                .init(id: 2),
                .init(id: 3)
            ]
        )

        // When
        viewModel.send(.setTextFieldText(.rowCoefficient(1), "3,33"))

        // Then
        XCTAssertEqual(viewModel.total.profitPercentage, "0%")
    }
}
