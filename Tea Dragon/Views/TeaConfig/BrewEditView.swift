//
//  NewBrewView.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 28.12.24.
//
import SwiftUI

struct BrewEditView: View {
    
    @Binding var show: Bool
    @Binding var brew: Brew
    @State var editedBrew: Brew = Brew()
    @EnvironmentObject var brewStore: BrewStore
    
    
    var body: some View {
        NavigationStack {
            BrewDetailView(brew: $editedBrew)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(role: .cancel) {
                            show = false
                        } label: {
                            Text("Cancel")
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button() {
                            // TODO: Are there other similar data validations neccesary? Move code to other location?
                            editedBrew.currentBrew = min(editedBrew.currentBrew, editedBrew.brewTimes.count)
                            brew = editedBrew
                            show = false
                        } label: {
                            Text("Done")
                        }
                    }
                }
                .navigationTitle("Edit Tea")
        }
        .onAppear {
            editedBrew = brew
        }
    }
}
