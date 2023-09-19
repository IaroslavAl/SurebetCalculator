//
//  SureBetCalculatorApp.swift
//  SureBet Calculator
//
//  Created by Iaroslav Beldin on 21.01.2023.
//

import SwiftUI

@main
struct SureBetCalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                SurebetCalculatorView()
            }
            .navigationViewStyle(.stack)
        }
    }
}
