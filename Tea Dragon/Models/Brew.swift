import Foundation

struct Brew: Identifiable, Codable {
    private let _id: UUID
    private var _teaName: String
    private var _temperature: Temperature
    private var _brewTimes: [TimePeriod]
    private var _spoons: Spoon
    private var _cup: Cup
    private var _currentBrew: Int
    private var _theme: Theme
    
    var brewAmount: Int {
        brewTimes.count
    }
    
    init(id: UUID = UUID(), teaName: String = "", temperature: Temperature = Temperature(celsius: 70.0), brewTimes: [TimePeriod] = [TimePeriod(minutes: 2, seconds: 0)], spoons: Spoon = Spoon(amount: 1), cup: Cup = Cup.smallCup, theme: Theme = .greenTea) {
        self._id = id
        self._teaName = teaName
        self._temperature = temperature
        self._brewTimes = brewTimes
        self._spoons = spoons
        self._cup = cup
        self._theme = theme
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
    
    
    var id: UUID {
        get {
            return _id
        }
    }
    
    var teaName: String {
        get {
            return _teaName
        }
        set {
            _teaName = newValue
        }
    }
    
    var temperature: Temperature {
        get {
            return _temperature
        }
        set {
            _temperature = newValue
        }
    }
    
    var brewTimes: [TimePeriod] {
        get {
            return _brewTimes
        }
        set {
            _brewTimes = newValue
        }
    }
    
    var spoons: Spoon {
        get {
            return _spoons
        }
        set {
            _spoons = newValue
        }
    }
    
    var cup: Cup {
        get {
            return _cup
        }
        set {
            _cup = newValue
        }
    }
    
    var currentBrew: Int {
        get {
            return _currentBrew
        }
        set {
            _currentBrew = newValue
        }
    }
    
    var theme: Theme {
        get {
            return _theme
        }
        set {
            _theme = newValue
        }
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
