import SwiftUI

struct OnboardingPageView: View {
    let page: OnboardingPage

    var body: some View {
        VStack(spacing: .zero) {
            Image(page.image, bundle: .module)
                .resizable()
                .scaledToFit()
                .padding(.vertical)
                .accessibilityLabel("Image")
            Spacer()
            Text(page.description)
                .font(.title)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .minimumScaleFactor(0.5)
            Spacer()
        }
    }
}

#Preview {
    OnboardingPageView(
        page: .init(
            image: "onboarding1",
            description: "description"
        )
    )
}
