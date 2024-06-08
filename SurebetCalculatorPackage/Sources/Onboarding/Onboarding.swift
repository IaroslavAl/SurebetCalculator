import SwiftUI

public enum Onboarding {
    public static func view(onboardingIsShown: Binding<Bool>) -> some View {
        OnboardingView(onboardingIsShown: onboardingIsShown)
    }
}
