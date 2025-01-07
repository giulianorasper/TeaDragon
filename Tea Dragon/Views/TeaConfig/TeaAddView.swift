//
//  NewBrewView.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 28.12.24.
//
import SwiftUI

struct TeaAddView: View {
    
    @Binding var show: Bool
    @EnvironmentObject var cupStore: DataStore
    @State var brew: Tea = Tea()
    @EnvironmentObject var brewStore: DataStore
    
    
    var body: some View {
        NavigationStack {
            TeaDetailView(brew: $brew)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            show = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            brewStore.brews.append(brew)
                            show = false
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
