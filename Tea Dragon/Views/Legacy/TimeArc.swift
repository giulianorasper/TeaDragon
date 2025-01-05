//
//  SpeakerArc.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 29.12.24.
//
import SwiftUI

struct TimeArc: Shape {
    var totalTime: TimePeriod
    var timeRemaining: TimePeriod
    
    private var degreesPerSpeaker: Double {
        360.0 / Double(totalTime.total_milliseconds)
    }
    private var startAngle: Angle {
        Angle(degrees: 0.0)
    }
    private var endAngle: Angle {
        Angle(degrees: degreesPerSpeaker * Double(timeRemaining.total_milliseconds))
    }
    
    func path(in rect: CGRect) -> Path {
        let diameter = min(rect.size.width, rect.size.height) - 12
        let radius = diameter / 2.0
        let center = CGPoint(x: rect.midX, y: rect.midY)
        return Path { path in
            path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        }
    }
}
