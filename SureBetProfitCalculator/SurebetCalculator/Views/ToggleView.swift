//
//  ToggleView.swift
//  SureBetProfitCalculator
//
//  Created by BELDIN Yaroslav on 03.02.2024.
//

import SwiftUI

struct ToggleView: View {
    let isOn: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: buttonAction) {
            if isOn {
                onState
            } else {
                offState
            }
        }
    }
}

private extension ToggleView {
    var height: CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 80 : 40
    }
    var transition: AnyTransition { .opacity.combined(with: .scale) }
    var animationDuration: Double { 0.25 }
    
    var onState: some View {
        Image(systemName: "soccerball")
            .frame(height: height)
            .foregroundColor(.green)
            .transition(transition)
    }
    
    var offState: some View {
        Image(systemName: "circle")
            .frame(height: height)
            .foregroundColor(.red)
            .transition(transition)
    }
    
    func buttonAction() {
        let impactFeedback = UIImpactFeedbackGenerator(style: .heavy)
        withAnimation(.easeInOut(duration: animationDuration)) {
            action()
            impactFeedback.impactOccurred()
        }
    }
}

#Preview {
    ToggleView(isOn: true, action: {})
}
