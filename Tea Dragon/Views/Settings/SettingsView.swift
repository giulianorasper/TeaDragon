//
//  LegalInfoView.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 05.01.25.
//
import SwiftUI

struct SettingsView : View {
    var body: some View {
        NavigationStack {
            List {
                Section("Legal Information") {
                    NavigationLink(destination: ImprintView()) {
                        Label("Imprint", systemImage: "info.circle")
                    }
                    NavigationLink(destination: PrivacyPolicyView()) {
                        Label("Privacy Policy", systemImage: "hand.raised.fill")
                    }
                }
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView()
}
