//
//  TeaEditView.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 28.12.24.
//
import SwiftUI

struct TeaEditView: View {
    
    @Binding var show: Bool
    @Binding var brew: Tea
    @State var editedBrew: Tea = Tea()
    @EnvironmentObject var brewStore: DataStore
    
    
    var body: some View {
        NavigationStack {
            TeaDetailView(brew: $editedBrew)
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
