//
//  AVPlazyer+Ding.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 29.12.24.
//

import Foundation
import AVFoundation

extension AVPlayer {
    static let sharedDingPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "gong", withExtension: "mp3") else { fatalError("Failed to find sound file.") }
        return AVPlayer(url: url)
    }()
    
    static let sharedTeaAmbientPlayer: AVQueuePlayer = AVQueuePlayer()
    
    static let sharedTeaAmbientLooper: AVPlayerLooper = {
        guard let url = Bundle.main.url(forResource: "onsen-ryokan-3曲", withExtension: "mp3") else { fatalError("Failed to find sound file.") }
        let playerItem = AVPlayerItem(url: url)
        
        let playerLooper: AVPlayerLooper = AVPlayerLooper(player: sharedTeaAmbientPlayer, templateItem: playerItem)
        
        return playerLooper
        
    }()
}

extension AVPlayerLooper {
    
}
