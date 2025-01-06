//
//  BrewControllerView.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 04.01.25.
//
import SwiftUI
import AVFoundation

struct BrewControllerView : View {
    @StateObject var teaTimer: TeaTimer = .init()
    @Binding var brew: Brew
    let teaPlayer: TeaAmbientPlayer = TeaAmbientPlayer.shared
    let dingPlayer: AVPlayer = AVPlayer.sharedDingPlayer
    
    var body: some View {
        let subtitle = Label("\(brew.currentBrew) / \(brew.brewTimes.count)", systemImage: Icon.brewAmount)
            .labelStyle(.trailingIcon)
        InteractiveProgressBar(title: Text("Steep Progress"), subtitle: subtitle, currentTime: $teaTimer.timeElapsed, totalTime: teaTimer.totalTime, hasPrevious: brew.hasPreviousBrew, isPlaying: $teaTimer.isRunning, hasNext: brew.hasNextBrew, previousAction: previousAction, nextAction: nextAction, playAction: playAction, pauseAction: pauseAction)
            .onAppear {
                teaTimer.reset(timePeriod: brew.brewTimes[brew.currentBrew-1])
                teaTimer.timerEndedAction = {
                    nextAction()
                    teaPlayer.playAlarm()
                    
                }
            }
            .onChange(of: brew.currentBrew) { oldValue, newValue in
                teaTimer.reset(timePeriod: brew.brewTimes[brew.currentBrew-1])
            }
            .onDisappear {
                pauseAction()
            }
    }
    
    func previousAction() {
        brew.currentBrew -= 1
        teaTimer.stop()
    }
    
    func nextAction() {
        brew.currentBrew += 1
        pauseAction()
    }
    
    func pauseAction() {
        teaTimer.stop()
        teaPlayer.pause()
    }
    
    func playAction() {
        teaTimer.start()
        teaPlayer.play()
    }
}

#Preview {
    @Previewable @State var brew = Brew.defaultData[0]
    BrewControllerView(brew: $brew)
}
