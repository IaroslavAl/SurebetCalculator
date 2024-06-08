import Onboarding
import ReviewHandler
import SurebetCalculator
import SwiftUI

struct RootView: View {
    @AppStorage("onboardingIsShown") private var onboardingIsShown = false
    @AppStorage("numberOfOpenings") private var numberOfOpenings = 0
    @State private var isAnimation = false

    var body: some View {
        Group {
            if onboardingIsShown {
                NavigationView {
                    SurebetCalculator.view()
                }
                .navigationViewStyle(.stack)
            } else {
                if isAnimation {
                    Onboarding.view(onboardingIsShown: $onboardingIsShown)
                        .transition(.move(edge: .bottom))
                }
            }
        }
        .preferredColorScheme(.dark)
        .animation(.default, value: onboardingIsShown)
        .onAppear(perform: showOnboardingView)
        .onAppear(perform: showRequestReview)
    }
}

private extension RootView {
    func showOnboardingView() {
        withAnimation {
            isAnimation = true
        }
    }

    func showRequestReview() {
        numberOfOpenings += 1
        if numberOfOpenings >= 5, onboardingIsShown {
            ReviewHandler.requestReview()
        }
    }
}
