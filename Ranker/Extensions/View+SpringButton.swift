//
//  View+SpringButton.swift
//  Ranker
//
//  Created by Will D on 11/11/24.
//

import SwiftUI

typealias Handler = () -> Void

struct SpringButton: ViewModifier {
    var isAnimating: Binding<Bool>
    var offset: Int
    var handler: Handler
    let animation = Animation.spring(response: 0.1, dampingFraction: 0.3, blendDuration: 0.1)
    
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                Task {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }
                withAnimation(animation) {
                    isAnimating.wrappedValue.toggle()
                } completion: {
                    withAnimation(animation) {
                        isAnimating.wrappedValue.toggle()
                    } completion: {
                        handler()
                    }
                }
            }
            .offset(
                x: isAnimating.wrappedValue ? CGFloat(offset) : 0,
                y: isAnimating.wrappedValue ? CGFloat(offset) : 0
            )
    }
}

extension View {
    func springButton(
        isAnimating: Binding<Bool> = .constant(false),
        offset: Int = 0,
        handler: @escaping Handler
    ) -> some View {
        modifier(SpringButton(isAnimating: isAnimating, offset: offset, handler: handler))
    }
}
