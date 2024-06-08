import SwiftUI

struct OnboardingIndex: View {
    @EnvironmentObject private var viewModel: OnboardingViewModel

    var body: some View {
        HStack(spacing: spacing) {
            ForEach(viewModel.pages.indices, id: \.self) { index in
                Circle()
                    .frame(width: size(index))
                    .foregroundColor(color(index))
            }
        }
        .animation(.default, value: viewModel.currentPage)
        .padding(padding)
        .fixedSize()
    }
}

private extension OnboardingIndex {
    var iPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    var spacing: CGFloat { iPad ? 12 : 8 }
    var padding: CGFloat { iPad ? 36 : 24 }

    func size(_ index: Int) -> CGFloat {
        if index == viewModel.currentPage {
            iPad ? 18 : 12
        } else {
            iPad ? 12 : 8
        }
    }

    func color(_ index: Int) -> Color {
        Color(uiColor: index == viewModel.currentPage ? .darkGray : .lightGray)
    }
}

#Preview {
    OnboardingIndex()
        .environmentObject(OnboardingViewModel())
}
