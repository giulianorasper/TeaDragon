//
//  TeaAmbientPlayer.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 05.01.25.
//


import AVFoundation
import AudioToolbox
import UserNotifications

// TODO: Disable ambient music if another sound source is playing

class TeaAmbientPlayer {
    
    
    static let shared = TeaAmbientPlayer() // Singleton instance
    
    let ambientPlayer: AVQueuePlayer
    let playerLooper: AVPlayerLooper
    let alarmPlayer: AVPlayer
    
    
    private init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, policy: .default, options: .mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch(let error) {
            print(error.localizedDescription)
        }
        self.ambientPlayer = AVQueuePlayer()
        self.ambientPlayer.volume = 0.1
        
        guard let url = Bundle.main.url(forResource: "onsen-ryokan-3曲", withExtension: "mp3") else {
            fatalError("Failed to find sound file.")
        }
        
        let playerItem = AVPlayerItem(url: url)
        
        self.playerLooper = AVPlayerLooper(player: ambientPlayer, templateItem: playerItem)
        
        guard let url = Bundle.main.url(forResource: "gong", withExtension: "mp3") else { fatalError("Failed to find sound file.") }
        self.alarmPlayer = AVPlayer(url: url)
    }
    
    func play() {
        self.ambientPlayer.play()
    }
    
    func pause() {
        self.ambientPlayer.pause()
    }
    
    func playAlarm() {
        self.alarmPlayer.seek(to: .zero)
        self.alarmPlayer.play()
        sendAlarmNotificaiton()
    }
    
    private func sendAlarmNotificaiton() {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.body = "Your tea is ready! Enjoy!"
        
        // Schedule the notification to trigger immediately
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        let request = UNNotificationRequest(identifier: "tea_done", content: content, trigger: trigger)
        
        // Push to notification center
        center.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
    
    func setMuted(_ muted: Bool) {
        self.ambientPlayer.isMuted = muted
    }
}
