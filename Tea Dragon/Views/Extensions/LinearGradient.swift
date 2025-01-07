//
//  LinearGradient.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 07.01.25.
//
import SwiftUI

extension LinearGradient {
    static let magic = LinearGradient(
        colors: [.red, .orange, .yellow, .green, .blue, .indigo, .purple],
        startPoint: .leading,
        endPoint: .trailing
    )
}
