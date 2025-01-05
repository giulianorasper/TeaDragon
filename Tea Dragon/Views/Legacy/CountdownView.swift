//
//  CountdownView.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 07.12.24.
//

import SwiftUI

struct CountdownView: View {
    @State private var remainingTime: Int // Time in seconds
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(startTime: Int) {
        _remainingTime = State(initialValue: startTime)
    }

    var body: some View {
        Text(timeString(from: remainingTime))
            .font(.system(size: 48))
            .padding()
            .onReceive(timer) { _ in
                if remainingTime > 0 {
                    remainingTime -= 1
                } else {
                    timer.upstream.connect().cancel() // Stop the timer when it reaches zero
                }
            }
    }

    // Helper function to format seconds as mm:ss
    private func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    CountdownView(startTime: 30)
}
