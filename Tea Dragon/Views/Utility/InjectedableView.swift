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
    @StateObject private var brewStore: BrewStore
    @StateObject private var cupStore: CupStore

    let content: Content

    init(content: Content, brewStore: BrewStore? = nil, cupStore: CupStore? = nil) {
        _brewStore = StateObject(wrappedValue: brewStore ?? BrewStore())
        _cupStore = StateObject(wrappedValue: cupStore ?? CupStore())
        self.content = content
    }

    var body: some View {
        content
            .environmentObject(brewStore)
            .environmentObject(cupStore)
    }
    
}

// Extension to inject dependencies
extension View {
    func inject(load: Bool = false, brewStore: BrewStore? = nil, cupStore: CupStore? = nil) -> some View {
        InjectedView(content: self, brewStore: brewStore, cupStore: cupStore)
            .task {
                if load {
                    do {
                        try await brewStore?.load()
                    } catch {
                        print("Error loading brews: \(error)")
                    }
                    do {
                        try await cupStore?.load()
                    } catch {
                        print("Error loading cups: \(error)")
                    }
                }
            }
    }
}
