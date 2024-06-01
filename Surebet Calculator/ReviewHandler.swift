//
//  ReviewHandler.swift
//  SureBet Profit Calculator
//
//  Created by Iaroslav Beldin on 18.04.2024.
//

import StoreKit
import SwiftUI

final class ReviewHandler {
    static func requestReview() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if let scene = UIApplication.shared.connectedScenes.first(
                where: {
                    $0.activationState == .foregroundActive
                }
            ) as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
    }
}
