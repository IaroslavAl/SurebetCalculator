import Banner
import SwiftUI

struct SurebetCalculatorView: View {
    @StateObject private var viewModel = SurebetCalculatorViewModel()

    var body: some View {
        VStack(spacing: spacing) {
            GeometryReader { geo in
                ScrollView(showsIndicators: false) {
                    VStack(spacing: spacing) {
                        Banner.view
                            .padding([.top, .horizontal], horizontalPadding)
                        TotalRowView()
                            .padding(.trailing, horizontalPadding)
                        rowsView
                        HStack(spacing: .zero) {
                            removeButton
                            addButton
                        }
                    }
                    .frame(
                        minWidth: geo.size.width,
                        minHeight: geo.size.height,
                        alignment: .top
                    )
                    .background(
                        Color.clear
                            .contentShape(.rect)
                            .onTapGesture {
                                viewModel.send(.hideKeyboard)
                            }
                    )
                }
            }
        }
        .navigationTitle(navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: toolbar)
        .frame(maxHeight: .infinity, alignment: .top)
        .font(font)
        .environmentObject(viewModel)
        .animation(.default, value: viewModel.selectedNumberOfRows)
    }
}

private extension SurebetCalculatorView {
    var rowsView: some View {
        VStack(spacing: rowsSpacing) {
            ForEach(viewModel.displayedRowIndexes, id: \.self) { id in
                RowView(id: id)
            }
        }
        .padding(.trailing, horizontalPadding)
    }

    @ToolbarContentBuilder
    func toolbar() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            NavigationClearButton()
        }
        ToolbarItemGroup(placement: .keyboard) {
            KeyboardClearButton()
            Spacer()
            KeyboardDoneButton()
        }
    }

    var addButton: some View {
        Image(systemName: "plus.circle")
            .foregroundStyle(viewModel.selectedNumberOfRows == .ten ? .gray : .green)
            .font(buttonFont)
            .disabled(viewModel.selectedNumberOfRows == .ten)
            .padding(8)
            .contentShape(.rect)
            .onTapGesture {
                viewModel.send(.addRow)
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            }
    }

    var removeButton: some View {
        Image(systemName: "minus.circle")
            .foregroundStyle(viewModel.selectedNumberOfRows == .two ? .gray : .red)
            .font(buttonFont)
            .disabled(viewModel.selectedNumberOfRows == .two)
            .padding(8)
            .contentShape(.rect)
            .onTapGesture {
                viewModel.send(.removeRow)
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            }
    }
}

private extension SurebetCalculatorView {
    var navigationTitle: String { "Surebet calculator" }
    var iPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    var spacing: CGFloat { iPad ? 24 : 16 }
    var rowsSpacing: CGFloat { iPad ? 12 : 8 }
    var horizontalPadding: CGFloat { iPad ? 12 : 8 }
    var font: Font { iPad ? .title : .body }
    var buttonFont: Font { iPad ? .largeTitle : .title }
}

#Preview {
    SurebetCalculatorView()
}
