//
//  NewBrewView.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 28.12.24.
//
import SwiftUI

struct TeaAddView: View {
    
    @EnvironmentObject var cupStore: DataStore
    @State var brew: Tea = Tea()
    @EnvironmentObject var brewStore: DataStore
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        NavigationStack {
            TeaDetailView(brew: $brew)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            brewStore.brews.append(brew)
                            dismiss()
                        }
                        .disabled(!brew.isValid)
                    }
                }
                .navigationTitle("New Tea")
        }
        .onAppear {
            brew.cup = cupStore.cups[0]
        }
    }
}
