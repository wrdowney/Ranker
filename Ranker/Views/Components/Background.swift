//
//  Background.swift
//  Ranker
//
//  Created by Will D on 11/11/24.
//

import SwiftUI

struct Background<Content>: View where Content: View{
    @ViewBuilder var content : () -> Content
    
    var body: some View {
        GeometryReader { proxy in
            let height: CGFloat = proxy.size.height
            let width: CGFloat = proxy.size.width
            ZStack(alignment: .bottomTrailing) {
                Color.backgroundColor
                    .ignoresSafeArea(.all)
                
                Image(systemName: "triangle")
                    .font(.system(size: 120, weight: .semibold))
                    .foregroundColor(.label)
                    .rotationEffect(Angle(degrees: 165))
                    .padding(24)
                    .opacity(0.4)
                    .offset(x: 0, y: -height * 0.65)
                
                Image(systemName: "triangle")
                    .font(.system(size: 120, weight: .semibold))
                    .foregroundColor(.label)
                    .rotationEffect(Angle(degrees: 65))
                    .padding(24)
                    .opacity(0.4)
                    .offset(x: -width * 0.4, y: -height * 0.45)
                
                Image(systemName: "triangle")
                    .font(.system(size: 120, weight: .semibold))
                    .foregroundColor(.label)
                    .rotationEffect(Angle(degrees: 135))
                    .padding(24)
                    .opacity(0.4)
                    .offset(x: 0, y: -height * 0.25)
                
                Image(systemName: "triangle")
                    .font(.system(size: 120, weight: .semibold))
                    .foregroundColor(.label)
                    .rotationEffect(Angle(degrees: 45))
                    .padding(24)
                    .opacity(0.4)
                    .offset(x: -width * 0.4, y: -height * 0.05)
                
                content()
            }
        }

    }
}

#Preview {
    Background {}
}
