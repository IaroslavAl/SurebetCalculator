//
//  ContentView.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 03.10.2023.
//

import StoreKit
import SwiftUI

struct ContentView: View {
    @StateObject private var surebetCalculatorViewModel = SurebetCalculatorViewModel()
    @StateObject private var onboardingViewModel = OnboardingViewModel()
    
    @AppStorage("onboardingIsShown") private var onboardingIsShown: Bool = false
    @AppStorage("numberOfOpenings") private var numberOfOpenings: Int = 0
    
    @State private var isAnimation: Bool = false
    
    var body: some View {
        Group {
            if onboardingIsShown {
                NavigationView {
                    SurebetCalculatorView()
                        .environmentObject(surebetCalculatorViewModel)
                }
                .navigationViewStyle(.stack)
            } else {
                if isAnimation {
                    OnboardingView(onboardingIsShown: $onboardingIsShown)
                        .environmentObject(onboardingViewModel)
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

private extension ContentView {
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

#Preview {
    ContentView()
}
