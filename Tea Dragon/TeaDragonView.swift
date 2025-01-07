//
//  ContentView.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 06.12.24.
//

import SwiftUI

struct TeaDragonView: View {
    
    let dataStore: DataStore = DataStore()
    
    var body: some View {
        TeaListView(saveAction: {
            Task {
                print("Save action triggered:")
                do {
                    try await dataStore.save()
                    print("- persisted tea store")
                } catch {
                    print("Error saving data store: \(error)")
                }
            }
        }).inject(load: true, dataStore: dataStore)
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
