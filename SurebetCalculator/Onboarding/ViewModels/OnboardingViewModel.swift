//
//  OnboardingViewModel.swift
//  SurebetCalculator
//
//  Created by Iaroslav Beldin on 03.10.2023.
//

import Foundation

final class OnboardingViewModel: ObservableObject {
    @Published var pages: [OnboardingPage]
    @Published var currentPage: Int
    
    init() {
        self.pages = OnboardingPage.createPages()
        self.currentPage = 0
    }
}
