//
//  Spoon.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 27.12.24.
//

struct Spoon: Hashable, Codable {
    var amount: Double
    
    func formatted() -> String {
        guard amount > 0.0 else { return "0 spoons" }
        let whole_spoons = Int(amount)
        let remainder = amount - Double(whole_spoons)
        
        if whole_spoons == 0 {
            return "1/2 spoons"
        }
        if amount == 1.0 {
            return "1 spoon"
        }
        if remainder > 0.0 {
            return "\(whole_spoons) 1/2 spoons"
        }
        return "\(whole_spoons) spoons"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(amount)
    }
    
    func adaptToCup(originalCup: Cup, newCup: Cup) -> Spoon {
        let adaptionFactor: Double = Double(newCup.volume.millilitres) / Double(originalCup.volume.millilitres)
        return Spoon(amount: self.amount * adaptionFactor)
    }
}
