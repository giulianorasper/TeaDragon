import Foundation

struct Brew: Identifiable, Codable {
    let id: UUID
    var teaName: String
    var temperature: Temperature
    var brewTimes: [TimePeriod]
    var spoons: Spoon
    var cup: Cup
    var _currentBrew: Int
    var theme: Theme
    
    var brewAmount: Int {
        brewTimes.count
    }
    
    var currentBrew: Int {
        get {
            return min(_currentBrew, brewAmount)
        }
        set {
            _currentBrew = (newValue-1) % brewAmount + 1
        }
    }
    
    init(id: UUID = UUID(), teaName: String = "", temperature: Temperature = Temperature(celsius: 70.0), brewTimes: [TimePeriod] = [TimePeriod(minutes: 2, seconds: 0)], spoons: Spoon = Spoon(amount: 1), cup: Cup = Cup.smallCup, theme: Theme = .greenTea) {
        self.id = id
        self.teaName = teaName
        self.temperature = temperature
        self.brewTimes = brewTimes
        self.spoons = spoons
        self.cup = cup
        self.theme = theme
        self._currentBrew = 1
    }
    
    var isDone: Bool {
        currentBrew < 1 || currentBrew > brewTimes.count
    }
    
    var isValid: Bool {
        !teaName.isEmpty && brewTimes.count > 0 && spoons.amount > 0 && cup.isValid
    }
    
    var hasPreviousBrew: Bool {
        currentBrew > 1
    }
    
    var hasNextBrew: Bool {
        currentBrew < brewTimes.count
    }
    
}


extension Brew {
    static let sampleData: [Brew] =
    [
        Brew(teaName: "Sencha",
             temperature: Temperature(celsius: 70.0),
             brewTimes: [TimePeriod(minutes: 0, seconds: 10), TimePeriod(minutes: 0, seconds: 15)],
             spoons: Spoon(amount: 1.0),
             cup: Cup.smallCup,
             theme: .greenTea
            ),
        Brew(teaName: "Jasmine",
             temperature: Temperature(celsius: 70.0),
             theme: .greenTea),
        Brew(teaName: "Dragon Fruit",
             temperature: Temperature(celsius: 100.0),
             theme: .fruitTea),
    ]
    
    static let defaultData: [Brew] =
    [
        Brew(teaName: NSLocalizedString("Sencha", comment: "Name of the tea: Sencha"),
             temperature: Temperature(celsius: 70.0),
             brewTimes: [TimePeriod(minutes: 1, seconds: 0), TimePeriod(minutes: 1, seconds: 30), TimePeriod(minutes: 2, seconds: 0)],
             spoons: Spoon(amount: 1.0),
             cup: Cup.smallCup,
             theme: .greenTea
            ),
    ]
}
