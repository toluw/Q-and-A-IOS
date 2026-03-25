//
//  CurvedTabBarShape.swift
//  Q and A
//
//  Created by GIGL-PC on 25/03/2026.
//

import Foundation
import SwiftUI

struct CurvedTabBarShape: Shape{
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
               
               let width = rect.width
               let height = rect.height
               
               let notchWidth: CGFloat = 120
               let notchDepth: CGFloat = 35
               
               let center = width / 2
               let leftNotchStart = center - notchWidth / 2
               let rightNotchEnd = center + notchWidth / 2
               
               path.move(to: CGPoint(x: 0, y: 0))
               
               // Left straight line
               path.addLine(to: CGPoint(x: leftNotchStart, y: 0))
               
               // Concave curve (dip down)
               path.addCurve(
                   to: CGPoint(x: rightNotchEnd, y: 0),
                   control1: CGPoint(x: center - notchWidth / 4, y: notchDepth),
                   control2: CGPoint(x: center + notchWidth / 4, y: notchDepth)
               )
               
               // Right straight line
               path.addLine(to: CGPoint(x: width, y: 0))
               
               // Close shape
               path.addLine(to: CGPoint(x: width, y: height))
               path.addLine(to: CGPoint(x: 0, y: height))
               path.closeSubpath()
               
               return path
     }
}
