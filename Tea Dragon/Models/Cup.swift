//
//  Cup.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 27.12.24.
//
import Foundation

struct Cup: Identifiable, Hashable, Codable {
    private var _id: UUID
    private var _name: String
    private var _volume: Volume
    
    var info: String {
        if volume.formatted() == "0ml" {
            return "\(name)"
        } else {
            return "\(name) (\(volume.formatted()))"
        }
    }
    
    init(id: UUID = UUID(), name: String = "", volume: Volume = .init(millilitres: 250)) {
        self._id = id
        self._name = name
        self._volume = volume
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
    
    var id: UUID {
        get {
            return _id
        }
        set {
            _id = newValue
        }
    }
    
    var name: String {
        get {
            return _name
        }
        set {
            _name = newValue
        }
    }
    
    var volume: Volume {
        get {
            return _volume
        }
        set {
            _volume = newValue
        }
    }
    
}

extension Cup {
    static let smallCup: Cup = .init(name: NSLocalizedString("Small Cup", comment: ""), volume: Volume(millilitres: 200))
    
    static let sampleData: [Cup] = [
        smallCup,
        .init(name: NSLocalizedString("Medium Cup", comment: ""), volume: Volume(millilitres: 300)),
        .init(name: NSLocalizedString("Grandma's Cup", comment: ""), volume: Volume(millilitres: 500)),
    ]
    
    static let defaultData: [Cup] = sampleData
    
    static let automaticCup: Cup = .init(name: NSLocalizedString("Recommendation", comment: ""), volume: Volume(millilitres: 0))
}
