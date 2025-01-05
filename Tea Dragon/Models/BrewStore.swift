//
//  TeaStore.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 28.12.24.
//

import Foundation

@MainActor
class BrewStore: Observable, ObservableObject {
    @Published var brews: [Brew] = Brew.sampleData
    
    func loadColoredBrews() {
        self.brews.removeAll()
        for theme in Theme.allCases {
            let brew: Brew = Brew(teaName: theme.name, theme: theme)
            self.brews.append(brew)
        }
    }
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("brews.data")
    }
    
    func load() async throws {
        let task = Task<[Brew], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                print("Could not load tea store, loading default")
                return Brew.defaultData
            }
            let brews = try JSONDecoder().decode([Brew].self, from: data)
            return brews
        }
        let brews = try await task.value
        print("Loaded \(brews.count) teas")
        self.brews = brews
    }
    
    func save(brews: [Brew]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(brews)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
