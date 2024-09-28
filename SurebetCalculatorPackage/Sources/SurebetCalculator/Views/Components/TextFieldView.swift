import SwiftUI

struct TextFieldView: View {
    @EnvironmentObject private var viewModel: SurebetCalculatorViewModel
    @FocusState private var isFocused: FocusableField?

    let placeholder: String
    let focusableField: FocusableField

    var body: some View {
        TextField(placeholder, text: bindingText)
            .textFieldStyle(
                .calculatorStyle(
                    isEnabled: !isDisabled,
                    isValid: text.isValidDouble()
                )
            )
            .focused($isFocused, equals: focusableField)
            .disabled(isDisabled)
            .onTapGesture {
                viewModel.send(.setFocus(focusableField))
            }
            .onChange(of: viewModel.focus) {
                isFocused = $0
            }
            .onChange(of: isFocused) { focus in
                if let focus {
                    viewModel.send(.setFocus(focus))
                }
            }
    }
}

private extension TextFieldView {
    var bindingText: Binding<String> {
        Binding(
            get: { text },
            set: { viewModel.send(.setTextFieldText(focusableField, $0)) }
        )
    }

    var isDisabled: Bool {
        switch (viewModel.selectedRow, focusableField) {
        case (_, .rowCoefficient):
            return false
        case (.none, .rowBetSize):
            return false
        case (.total, .totalBetSize):
            return false
        case let (.row(selectedId), .rowBetSize(currentId)):
            if selectedId == currentId {
                return false
            }
            return true
        default:
            return true
        }
    }

    var text: String {
        switch focusableField {
        case .totalBetSize:
            return viewModel.total.betSize
        case let .rowBetSize(id):
            return viewModel.rows[id].betSize
        case let .rowCoefficient(id):
            return viewModel.rows[id].coefficient
        }
    }
}

#Preview {
    TextFieldView(
        placeholder: "Total bet size",
        focusableField: .totalBetSize
    )
    .padding()
    .environmentObject(SurebetCalculatorViewModel())
}
