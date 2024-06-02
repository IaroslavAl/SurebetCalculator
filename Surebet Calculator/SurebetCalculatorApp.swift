//
//  SurebetCalculatorApp.swift
//  SureBet Calculator
//
//  Created by Iaroslav Beldin on 21.01.2023.
//

import AppMetricaCore
import SwiftUI

@main
struct SurebetCalculatorApp: App {
    @StateObject private var surebetCalculatorViewModel = SurebetCalculatorViewModel()
    @StateObject private var onboardingViewModel = OnboardingViewModel()

    @UIApplicationDelegateAdaptor(AppDelegate.self) private var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(surebetCalculatorViewModel)
                .environmentObject(onboardingViewModel)
        }
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        let apiKey = "f7e1f335-475a-4b6c-ba4a-77988745bc7a"
        if let configuration = AppMetricaConfiguration(apiKey: apiKey) {
            AppMetrica.activate(with: configuration)
        }
        return true
    }
}
