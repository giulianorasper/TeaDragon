//
//  Volume.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 27.12.24.
//

struct Volume: Codable {
    var millilitres: Int
    
    init(millilitres: Int = 42) {
        self.millilitres = millilitres
    }
    
    var millilitres_string: String {
        get {
            return String(millilitres)
        }
        set {
            millilitres = Int(newValue) ?? 0
        }
    }
    
    func formatted() -> String {
        String(millilitres) + unit()
    }
    
    func unit() -> String {
        return "ml"
    }
}
