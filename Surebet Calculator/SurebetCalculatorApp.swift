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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        let apiKey = "ae83fb52-20cf-4836-bc75-a4b3038ee3fe"
        let configuration = AppMetricaConfiguration(apiKey: apiKey)
        AppMetrica.activate(with: configuration!)
        return true
    }
}
