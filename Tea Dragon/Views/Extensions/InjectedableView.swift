//
//  InjectedView.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 27.12.24.
//
import SwiftUI

// Wrapper view to handle injection
@MainActor
struct InjectedView<Content: View>: View {
    @StateObject private var dataStore: DataStore
    
    let content: Content
    
    init(content: Content, dataStore: DataStore? = nil) {
        _dataStore = StateObject(wrappedValue: dataStore ?? DataStore())
        self.content = content
    }
    
    var body: some View {
        content
            .environmentObject(dataStore)
    }
    
}

// Extension to inject dependencies
extension View {
    func inject(load: Bool = false, dataStore: DataStore? = nil) -> some View {
        InjectedView(content: self, dataStore: dataStore)
            .task {
                if load {
                    do {
                        try await dataStore?.load()
                    } catch {
                        print("Error loading data store: \(error)")
                    }
                }
            }
    }
}
