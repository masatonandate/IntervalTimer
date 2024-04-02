//
//  exerciseArc.swift
//  intervalTimer
//
//  Created by Masato Nandate on 6/2/23.
//

import Foundation
import SwiftUI

struct exerciseArc: Shape{
    let currSeconds: Int
    let totalSeconds: Int
    var startAngle: Angle
    var clockwise: Bool
    
    private var endAngle: Angle{
        Angle(degrees: 360.0 - (Double(currSeconds) * (360.0 / Double(totalSeconds))))
    }
    
    
    func path(in rect: CGRect) -> Path {
            var path = Path()
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
            return path
        
        }
}
