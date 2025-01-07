//
//  ProgressBar.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 07.01.25.
//
import SwiftUI

struct ProgressBar: View {
    @State private var isInteracting: Bool = false // Tracks interaction state
    @Binding var currentTime: TimePeriod
    let totalTime: TimePeriod
    
    var body: some View {
        var progress: Double {
            get {
                return Double(currentTime.total_milliseconds) / Double(totalTime.total_milliseconds)
            }
            set {
                currentTime.total_milliseconds = Int(newValue * Double(totalTime.total_milliseconds))
            }
        }
        
        
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background track
                Capsule()
                    .fill(Color.secondary.opacity(0.3))
                    .frame(height: isInteracting ? 12 : 8) // Thickness increases when interacting
                
                // Progress fill
                Capsule()
                    .fill(Color.accentColor)
                    .frame(width: CGFloat(progress) * geometry.size.width, height: isInteracting ? 12 : 8)
                    .animation(.easeInOut(duration: 0.2), value: progress)
            }
            .frame(height: 8)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        isInteracting = true
                        let location = value.location.x / geometry.size.width
                        progress = max(0, min(1, Double(location))) // Clamp between 0 and 1
                    }
                    .onEnded { _ in
                        isInteracting = false
                    }
            )
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isInteracting)
        }
        .frame(height: 20)
        .padding(.horizontal)
    }
}
