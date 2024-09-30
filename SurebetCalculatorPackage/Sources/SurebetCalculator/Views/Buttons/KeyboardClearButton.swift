import SwiftUI

struct KeyboardClearButton: View {
    @EnvironmentObject private var viewModel: SurebetCalculatorViewModel

    var body: some View {
        Button {
            viewModel.send(.clearFocusableField)
        } label: {
            Text("Clear")
                .foregroundColor(.red)
        }
    }
}

#Preview {
    KeyboardClearButton()
        .environmentObject(SurebetCalculatorViewModel())
}
