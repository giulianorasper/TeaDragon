//
//  ContentView.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 06.12.24.
//

import SwiftUI

struct TeaDragonView: View {
    
    let brewStore: TeaStore = TeaStore()
    let cupStore: CupStore = CupStore()
    
    var body: some View {
        TeaListView(saveAction: {
            Task {
                print("Save action triggered:")
                do {
                    try await brewStore.save(brews: brewStore.brews)
                    print("- persisted tea store")
                } catch {
                    print("Error saving brews: \(error)")
                }
                do {
                    try await cupStore.save(cups: cupStore.cups)
                    print("- persisted cup store")
                } catch {
                    print("Error saving cups: \(error)")
                }
            }
        }).inject(load: true, brewStore: brewStore, cupStore: cupStore)
            .task {
                do {
                    let center = UNUserNotificationCenter.current()
                    try await center.requestAuthorization(options: [.alert, .sound, .provisional])
                } catch {
                    print("Authorization failed: \(error.localizedDescription)")
                }
            }
    }
}

#Preview("English") {
    TeaDragonView()
}

#Preview("Japanese") {
    TeaDragonView()
        .environment(\.locale, Locale(identifier: "ja_JP"))
}

#Preview("German") {
    TeaDragonView()
        .environment(\.locale, Locale(identifier: "de"))
}
