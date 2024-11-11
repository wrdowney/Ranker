//
//  Header.swift
//  Ranker
//
//  Created by Will D on 11/11/24.
//

import SwiftUI

struct Header: View {
    @State private var profilePictureIsAnimating = false
    @State private var rotation: Double = 0
    var body: some View {
        HStack {
            Image("headshot")
                .resizable()
                .foregroundColor(.black)
                .padding(2)
                .scaledToFit()
                .background(.white)
                .clipShape(Circle())
                .dropBorder(shapeType: .circle, isAnimating: $profilePictureIsAnimating)
                .springButton(isAnimating: $profilePictureIsAnimating){}
                .frame(width: 52, height: 52)
            Spacer()
            Button {
                Task {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }
                withAnimation(.linear(duration: 0.2)) {
                    rotation -= 360
                }
            } label: {
                Image(systemName: "gearshape")
                    .font(.system(size: 28, weight: .bold))
                    .rotationEffect(Angle(degrees: rotation))
                    .foregroundStyle(.black)
            }
            .frame(width: 44, height: 44)
        }
        .buttonStyle(.plain)
        .padding(.horizontal)
        .background(Color.backgroundColor)
    }
}

#Preview {
    Header()
}
