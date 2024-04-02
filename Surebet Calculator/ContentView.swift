//
//  ContentView.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 03.10.2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboardingIsDone") private var onboardingIsDone: Bool = false
    @StateObject private var surebetCalculatorViewModel = SurebetCalculatorViewModel()
    
    var body: some View {
        if onboardingIsDone {
            NavigationView {
                SurebetCalculatorView()
                    .environmentObject(surebetCalculatorViewModel)
            }
            .navigationViewStyle(.stack)
            .preferredColorScheme(.dark)
        } else {
            OnboardingView($onboardingIsDone)
                .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
