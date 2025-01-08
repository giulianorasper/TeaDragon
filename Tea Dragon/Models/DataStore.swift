//
//  TeaStore.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 28.12.24.
//

import Foundation

@MainActor
class DataStore: Observable, ObservableObject {
    @Published var dataObject: DataObject = DataObject()
    
    var brews: [Tea] {
        get {
            self.dataObject.teas
        }
        set {
            self.dataObject.teas = newValue
        }
    }
    
    var cups: [Cup] {
        get {
            self.dataObject.cups
        }
        set {
            self.dataObject.cups = newValue
        }
    }
    
    var settings: Settings {
        get {
            self.dataObject.settings
        }
        set {
            self.dataObject.settings = newValue
        }
    }
    
    func updateTea(_ tea: Tea) {
        if let index = brews.firstIndex(where: { $0.id == tea.id }) {
            brews[index] = tea
        }
    }
    
    func removeTea(_ tea: Tea) {
        if let index = brews.firstIndex(where: { $0.id == tea.id }) {
            brews.remove(at: index)
        }
    }
    
    func loadColoredBrews() {
        self.brews.removeAll()
        for theme in TeaType.allCases {
            let brew: Tea = Tea(teaName: theme.name, theme: theme)
            self.brews.append(brew)
        }
    }
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("data")
    }
    
    func load() async throws {
        let task = Task<DataObject, Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                print("Could not load data store, loading default")
                return DataObject()
            }
            let dataObject = try JSONDecoder().decode(DataObject.self, from: data)
            return dataObject
        }
        let dateObject = try await task.value
        self.dataObject = dateObject
        print("Loaded \(brews.count) teas and \(cups.count) cups.")
    }
    
    func save() async throws {
        let task = Task {
            let data = try JSONEncoder().encode(self.dataObject)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}

struct DataObject: Codable {
    var teas: [Tea] = Tea.defaultData
    var cups: [Cup] = Cup.defaultData
    var settings: Settings = Settings()
    
    init(){}
    
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.teas = (try? container.decode([Tea].self, forKey: .teas)) ?? Tea.defaultData
        self.cups = (try? container.decode([Cup].self, forKey: .cups)) ?? Cup.defaultData
        self.settings = (try? container.decode(Settings.self, forKey: .settings)) ?? Settings()
    }
}
