//
//  CupStore.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 27.12.24.
//
import Foundation

@MainActor
class CupStore: Observable, ObservableObject {
    @Published var cups: [Cup] = Cup.sampleData
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("cups.data")
    }
    
    func load() async throws {
        let task = Task<[Cup], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                print("Could not load cup store, loading default")
                return Cup.defaultData
            }
            let cups = try JSONDecoder().decode([Cup].self, from: data)
            return cups
        }
        let cups = try await task.value
        print("Loaded \(cups.count) cups")
        self.cups = cups
    }
    
    func save(cups: [Cup]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(cups)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
