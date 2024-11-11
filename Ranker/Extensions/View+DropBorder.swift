//
//  View+DropBorder.swift
//  Ranker
//
//  Created by Will D on 11/11/24.
//

import SwiftUI

enum ShapeType {
    case roundedRectangle(cornerRadius: CGFloat)
    case circle
    case capsule
    
    var shape: AnyShape {
        switch self {
        case .roundedRectangle(let cornerRadius):
            return AnyShape(RoundedRectangle(cornerRadius: cornerRadius))
        case .circle:
            return AnyShape(Circle())
        case .capsule:
            return AnyShape(Capsule())
        }
    }
}

struct DropBorder: ViewModifier {
    var offset: CGFloat
    var color: Color
    var lineWidth: CGFloat
    var shapeType: ShapeType
    var isAnimating: Binding<Bool>
    
    func body(content: Content) -> some View {
        content
            .shadow(
                color: color,
                radius: 0,
                x: isAnimating.wrappedValue ? 0 : offset,
                y: isAnimating.wrappedValue ? 0 : offset
            )
            .overlay {
                shapeType.shape
                    .stroke(color, lineWidth: lineWidth)
            }
    }
}

extension View {
    func dropBorder(
        offset: CGFloat = 3,
        color: Color = .black,
        lineWidth: CGFloat = 3,
        shapeType: ShapeType = .roundedRectangle(cornerRadius: 0),
        isAnimating: Binding<Bool> = .constant(false)
    ) -> some View {
        modifier(DropBorder(offset: offset, color: color, lineWidth: lineWidth, shapeType: shapeType, isAnimating: isAnimating))
    }
}
