import SwiftUI

enum Theme: String, CaseIterable, Identifiable, Codable {
    case greenTea
    case blackTea
    case whiteTea
    case oolongTea
    case herbalTea
    case fruitTea
    case matchaTea
    case puerhTea
    case yellowTea
    case chaiTea
    case rooibosTea
    case other
    
    var accentColor: Color {
        switch self {
        case .whiteTea, .yellowTea:
            return .black
        default:
            return .white
        }
    }
    
    var mainColor: Color {
        switch self {
        case .greenTea: return Color.green.opacity(0.7) // Matcha-like green
        case .blackTea: return Color.brown.opacity(0.8) // Dark brown
        case .whiteTea: return Color.white.opacity(0.9) // Soft white
        case .oolongTea: return Color.brown.opacity(0.6) // Light tan
        case .herbalTea: return Color.orange.opacity(0.7) // Soft orange
        case .fruitTea: return Color.red.opacity(0.8) // Vivid red-pink
        case .matchaTea: return Color.green // Bright green
        case .puerhTea: return Color.brown.opacity(0.7) // Earthy brown
        case .yellowTea: return Color.yellow.opacity(0.8) // Warm yellow
        case .chaiTea: return Color.brown.opacity(0.5) // Warm beige
        case .rooibosTea: return Color.red.opacity(0.6) // Reddish-brown
        case .other: return Color.orange.opacity(0.8) // Cool caramel orange
        }
    }
    
    var name: String {
        switch self {
        case .greenTea: return "Green Tea"
        case .blackTea: return "Black Tea"
        case .whiteTea: return "White Tea"
        case .oolongTea: return "Oolong Tea"
        case .herbalTea: return "Herbal Tea"
        case .fruitTea: return "Fruit Tea"
        case .matchaTea: return "Matcha Tea"
        case .puerhTea: return "Pu-erh Tea"
        case .yellowTea: return "Yellow Tea"
        case .chaiTea: return "Chai Tea"
        case .rooibosTea: return "Rooibos Tea"
        case .other: return "Other"
        }
    }
    
    var id: String { name }
}
