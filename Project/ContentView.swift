//
//  ContentView.swift
//  SurebetCalculator
//
//  Created by Iaroslav Beldin on 03.10.2023.
//

import Root
import SwiftUI

struct ContentView: View {
    @AppStorage("onboardingIsDone") private var onboardingIsDone: Bool = false
    
    var body: some View {
        if onboardingIsDone {
            NavigationView {
                SurebetCalculator()
            }
            .navigationViewStyle(.stack)
            .preferredColorScheme(.dark)
        } else {
            Onboarding($onboardingIsDone)
                .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
