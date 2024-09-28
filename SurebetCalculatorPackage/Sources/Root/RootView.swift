import Onboarding
import ReviewHandler
import SurebetCalculator
import SwiftUI

struct RootView: View {
    @AppStorage("onboardingIsShown") private var onboardingIsShown = false
    @AppStorage("requestReviewWasShon") private var requestReviewWasShon = false
    @AppStorage("numberOfOpenings") private var numberOfOpenings = 0

    @State private var isAnimation = false
    @State private var alertIsPresented = false

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
        .alert(requestReviewTitle, isPresented: $alertIsPresented) {
            Button("No") {
                alertIsPresented = false
            }
            Button("Yes") {
                alertIsPresented = false
                ReviewHandler.requestReview()
            }
        }
    }
}

private extension RootView {
    var requestReviewTitle: String {
        "Enjoying Calculator"
    }

    func showOnboardingView() {
        withAnimation {
            isAnimation = true
        }
    }

    func showRequestReview() {
#if !DEBUG
        Task {
            try await Task.sleep(nanoseconds: NSEC_PER_SEC * 1)
            if !requestReviewWasShon, numberOfOpenings >= 5, onboardingIsShown {
                numberOfOpenings += 1
                alertIsPresented = true
                requestReviewWasShon = true
            }
        }
#endif
    }
}
