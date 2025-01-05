//
//  TeaTimerView.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 28.12.24.
//
import SwiftUI
import AVFoundation

struct GradientCircleView: View {
    
    var body: some View {
        Circle()
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [Color.green, Color.blue]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .padding(20)
    }
}

struct CircleTimerView: View {
    @StateObject var teaTimer: TeaTimer = TeaTimer()
    var timePeriod: TimePeriod
    var timerStartedAction: (() -> Void)?
    var timerEndedAction: (() -> Void)?
    
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }
    
    var body: some View {
        Circle()
            .rotation(Angle(degrees: -90))
            .strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 12, lineCap: .round))
            .overlay {
                TimeArc(totalTime: timePeriod, timeRemaining: teaTimer.timeRemaining)
                    .rotation(Angle(degrees: -90))
                    .stroke(.yellow, style: StrokeStyle(lineWidth: 12, lineCap: .round))
            }
            .overlay {
                GradientCircleView()
            }
            .overlay {
                VStack {
                    Text(String(teaTimer.timeRemaining.formatTime()))
                        .font(.largeTitle)
                }
            }
//            .shadow(color: .black, radius: 15)
            .onAppear {
                startTimer()
            }
            .onChange(of: timePeriod) {
                startTimer()
            }
            .onDisappear {
                stopTimer()
            }
    }
    
    private func startTimer() {
        stopTimer()
        teaTimer.reset(timePeriod: timePeriod)
        teaTimer.start()
        timerStartedAction?()
        teaTimer.timerEndedAction = {
            player.seek(to: .zero)
            player.play()
            timerEndedAction?()
        }
    }
    
    private func stopTimer() {
        teaTimer.stop()
    }
}

#Preview {
    let timePeriod: TimePeriod = .init(seconds: 60)
    
    CircleTimerView(timePeriod: timePeriod)
}
