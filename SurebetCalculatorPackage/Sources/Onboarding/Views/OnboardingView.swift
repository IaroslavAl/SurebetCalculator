import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    @Binding var onboardingIsShown: Bool

    var body: some View {
        VStack(spacing: .zero) {
            OnboardingCloseButton()
            OnboardingTabView()
            OnboardingIndex()
            OnboardingButton()
        }
        .padding()
        .onChange(of: viewModel.onboardingIsShown) {
            onboardingIsShown = $0
        }
        .environmentObject(viewModel)
    }
}

#Preview {
    OnboardingView(onboardingIsShown: .constant(false))
}
