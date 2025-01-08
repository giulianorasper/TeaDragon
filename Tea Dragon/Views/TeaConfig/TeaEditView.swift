//
//  TeaEditView.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 28.12.24.
//
import SwiftUI

struct TeaEditView: View {
    
    @State var tea: Tea
    @EnvironmentObject var dataStore: DataStore
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        NavigationStack {
            TeaDetailView(brew: $tea)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(role: .cancel) {
                            dismiss()
                        } label: {
                            Text("Cancel")
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button() {
                            tea.currentBrew = min(tea.currentBrew, tea.brewTimes.count)
                            dataStore.updateTea(tea)
                            dismiss()
                        } label: {
                            Text("Done")
                        }
                    }
                }
                .navigationTitle("Edit Tea")
        }
    }
}
