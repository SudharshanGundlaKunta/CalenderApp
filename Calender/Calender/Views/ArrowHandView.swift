//
//  ArrowHandView.swift
//  Calender
//
//  Created by Apple on 18/02/25.
//

import SwiftUI

struct ArrowHand: Shape {
    var handLength: CGFloat
    var handWidth: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Draw the shaft as a rectangle.
        let shaftRect = CGRect(x: -handWidth / 2,
                               y: -handLength * 0.8,
                               width: handWidth,
                               height: handLength * 0.8)
        path.addRect(shaftRect)
        
        // Draw the arrowhead as a triangle.
        path.move(to: CGPoint(x: -handWidth, y: -handLength * 0.8))
        path.addLine(to: CGPoint(x: 0, y: -handLength))
        path.addLine(to: CGPoint(x: handWidth, y: -handLength * 0.8))
        path.closeSubpath()
        
        // Center the drawing within the given rect.
        let transform = CGAffineTransform(translationX: rect.midX, y: rect.midY)
        return path.applying(transform)
    }
}

#Preview(body: {
    ArrowHand(handLength: 100, handWidth: 100)
})
