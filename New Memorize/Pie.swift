//
//  Pie.swift
//  New Memorize
//
//  Created by Sankarshana V on 2022/01/01.
//

import SwiftUI

struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var antiClockwise = true
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(startAngle.radians, endAngle.radians)
        }
        set {
            startAngle = Angle.radians(newValue.first)
            endAngle = Angle.radians(newValue.second)
        }
    }
    
    // Protocol stub for Shape
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: center.x + radius * CGFloat(cos(startAngle.radians)),
            y: center.y + radius * CGFloat(sin(startAngle.radians))
        )
    
        // Adding paths for the pie
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: antiClockwise
        )
        p.addLine(to: center)
        return p
    }
}
