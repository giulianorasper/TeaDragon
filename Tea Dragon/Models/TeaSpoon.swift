//
//  Spoon.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 27.12.24.
//
import Foundation

struct TeaSpoon: Hashable, Codable {
    private var _amount: Double
    
    var amount: Double {
        get { _amount }
        set { _amount = newValue }
    }
    
    init(amount: Double) {
        self._amount = amount
    }
    
    
    func formatted() -> String {
        guard amount > 0.0 else { return "0 spoons" }
        let formattedAmount: String
        if amount.truncatingRemainder(dividingBy: 1) == 0 {
            // No fractional part, format as an integer
            formattedAmount = String(format: NSLocalizedString("%.0f teaspoons", comment: "The amount of teaspoons"), amount)
        } else {
            // Fractional part exists, format with one decimal place
            formattedAmount = String(format: NSLocalizedString("%.1f teaspoons", comment: "The amount of teaspoons"), amount)
        }
        return formattedAmount
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(amount)
    }
    
    func adaptToCup(originalCup: Cup, newCup: Cup) -> TeaSpoon {
        let adaptionFactor: Double = Double(newCup.volume.millilitres) / Double(originalCup.volume.millilitres)
        return TeaSpoon(amount: self.amount * adaptionFactor)
    }
}
