//
//  Temperature.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 27.12.24.
//

struct Temperature: Hashable, Codable {
    private var _celsius: Double
    
    var celsius: Double {
        get { _celsius }
        set { _celsius = newValue }
    }
    
    init(celsius: Double) {
        self._celsius = celsius
    }
    
    var text: String {
        set {
            celsius = Double(newValue) ?? 0
        }
        get {
            String(Int(celsius))
        }
    }
    
    func formatted() -> String {
        String(Int(celsius)) + unit()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(celsius)
    }
    
    static func == (lhs: Temperature, rhs: Temperature) -> Bool {
        lhs.celsius == rhs.celsius
    }
    
    func unit() -> String {
        return "°C"
    }
}
