import AnalyticsManager
import Onboarding
import ReviewHandler
import SurebetCalculator
import SwiftUI

struct RootView: View {
    @AppStorage("onboardingIsShown") private var onboardingIsShown = false
    @AppStorage("1.4.0") private var requestReviewWasShon = false
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
                AnalyticsManager.log(name: "RequestReview", parameters: ["enjoying_calculator": false])
            }
            Button("Yes") {
                alertIsPresented = false
                ReviewHandler.requestReview()
                AnalyticsManager.log(name: "RequestReview", parameters: ["enjoying_calculator": true])
            }
        }
    }
}

private extension RootView {
    var requestReviewTitle: String {
        "Do you like the app?"
    }

    func showOnboardingView() {
        withAnimation {
            isAnimation = true
        }
    }

    func showRequestReview() {
#if !DEBUG
        Task {
            numberOfOpenings += 1
            try await Task.sleep(nanoseconds: NSEC_PER_SEC * 1)
            if !requestReviewWasShon, numberOfOpenings >= 5, onboardingIsShown {
                alertIsPresented = true
                requestReviewWasShon = true
            }
        }
#endif
    }
}
