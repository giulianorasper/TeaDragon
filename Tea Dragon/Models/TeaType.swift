import SwiftUI

enum TeaType: String, CaseIterable, Identifiable, Codable {
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
        case .greenTea: return NSLocalizedString("Green Tea", comment: "")
        case .blackTea: return NSLocalizedString("Black Tea", comment: "")
        case .whiteTea: return NSLocalizedString("White Tea", comment: "")
        case .oolongTea: return NSLocalizedString("Oolong Tea", comment: "")
        case .herbalTea: return NSLocalizedString("Herbal Tea", comment: "")
        case .fruitTea: return NSLocalizedString("Fruit Tea", comment: "")
        case .matchaTea: return NSLocalizedString("Matcha Tea", comment: "")
        case .puerhTea: return NSLocalizedString("Pu-erh Tea", comment: "")
        case .yellowTea: return NSLocalizedString("Yellow Tea", comment: "")
        case .chaiTea: return NSLocalizedString("Chai Tea", comment: "")
        case .rooibosTea: return NSLocalizedString("Rooibos Tea", comment: "")
        case .other: return NSLocalizedString("Other", comment: "")
        }
    }

    
    var id: String { name }
}
