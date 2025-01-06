//
//  NewBrewView.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 28.12.24.
//
import SwiftUI

struct NewBrewView: View {
    
    @Binding var show: Bool
    @EnvironmentObject var cupStore: CupStore
    @State var brew: Brew = Brew()
    @EnvironmentObject var brewStore: BrewStore
    
    
    var body: some View {
        NavigationStack {
            BrewDetailView(brew: $brew)
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
