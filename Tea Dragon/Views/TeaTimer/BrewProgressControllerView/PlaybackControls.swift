//
//  PlaybackControls.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 07.01.25.
//
import SwiftUI


struct PlaybackControls: View {
    var hasPrevious: Bool
    var hasNext: Bool
    var isPlaying: Bool
    var previousAction: (() -> Void)?
    var playAction: (() -> Void)?
    var pauseAction: (() -> Void)?
    var nextAction: (() -> Void)?
    
    var body: some View {
        HStack {
            Button(action: {
                previousAction?()
            }) {
                Image(systemName: "backward.fill")
            }
            .disabled(!hasPrevious)
            Spacer()
            if isPlaying {
                Button(action: {
                    pauseAction?()
                }) {
                    Image(systemName: "pause.fill")
                }
            } else {
                Button(action: {
                    playAction?()
                }) {
                    Image(systemName: "play.fill")
                }
            }
            Spacer()
            Button(action: {
                nextAction?()
            }) {
                Image(systemName: "forward.fill")
            }
            .disabled(!hasNext)
        }
        .padding(.horizontal)
        .font(Font.system(size: 40))
        .padding()
        .padding(.bottom)
    }
}
