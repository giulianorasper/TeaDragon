//
//  Cup.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 27.12.24.
//
import Foundation

struct Cup: Identifiable, Hashable, Codable {
    var id: UUID
    var name: String
    var volume: Volume
    
    var info: String {
        if volume.formatted() == "0ml" {
            return "\(name)"
        } else {
            return "\(name) (\(volume.formatted()))"
        }
    }
    
    init(id: UUID = UUID(), name: String = "", volume: Volume = .init(millilitres: 250)) {
        self.id = id
        self.name = name
        self.volume = volume
    }
    
    func copy() -> Cup {
        Cup(name: name, volume: volume)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func == (lhs: Cup, rhs: Cup) -> Bool {
        lhs.name == rhs.name
    }
    
    var isValid: Bool { !name.isEmpty && volume.millilitres > 0}
    
}

extension Cup {
    static let smallCup: Cup = .init(name: "Small Cup", volume: Volume(millilitres: 200))
    
    static let sampleData: [Cup] = [
        smallCup,
        .init(name: NSLocalizedString("Medium Cup", comment: ""), volume: Volume(millilitres: 300)),
        .init(name: NSLocalizedString("Grandma's Cup", comment: ""), volume: Volume(millilitres: 500)),
    ]
    
    static let defaultData: [Cup] = sampleData
    
    static let automaticCup: Cup = .init(name: NSLocalizedString("Recommendation", comment: ""), volume: Volume(millilitres: 0))
}
