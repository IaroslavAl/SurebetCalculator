import SwiftUI

struct OnboardingTabView: View {
    @EnvironmentObject private var viewModel: OnboardingViewModel

    var body: some View {
        TabView(selection: selection) {
            ForEach(viewModel.pages.indices, id: \.self) { index in
                OnboardingPageView(page: viewModel.pages[index])
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .animation(.default, value: viewModel.currentPage)
        .transition(.move(edge: .trailing))
    }
}

private extension OnboardingTabView {
    var selection: Binding<Int> {
        .init(
            get: { viewModel.currentPage },
            set: { viewModel.send(.setCurrentPage($0)) }
        )
    }
}

#Preview {
    OnboardingTabView()
        .environmentObject(OnboardingViewModel())
}
