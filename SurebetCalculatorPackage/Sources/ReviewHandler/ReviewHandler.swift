import StoreKit
import SwiftUI

public final class ReviewHandler {
    public static func requestReview() {
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
