//
//  Settings.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 07.01.25.
//

struct Settings:  Codable, Equatable {
    private var _mutePlayback: Bool = false
    
    var mutePlayback: Bool {
        get { _mutePlayback }
        set { _mutePlayback = newValue }
    }
}
