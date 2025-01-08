//
//  ContentView.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 06.12.24.
//

import SwiftUI

struct TeaListView: View {
    @EnvironmentObject var brewStore: DataStore
    @State var presentAddBrew: Bool = false
    @State var editedTea: Tea? = nil
    @State var presentEditBrew: Bool = false
    @State var timedBrew: Tea = Tea()
    @State var presentTimedBrew: Bool = false
    @State var presentNewBrew: Bool = false
    @State var selectedCup: Cup = Cup.automaticCup
    @State var showLegalInfo: Bool = false
    @Environment(\.scenePhase) private var scenePhase
    var saveAction: (()->Void)?
    
    var body: some View {
        NavigationStack {
            List{
                Section("cup to show intructions for") {
                    HStack {
                        Label("Cup", systemImage: Icon.cup)
                        Spacer()
                        CupPicker(selection: $selectedCup, allowAutomaticSelection: true)
                    }
                }
                Section("Teas") {
                    ForEach($brewStore.brews, id: \.id) { $brew in
                        Button(action: {
                            timedBrew = brew
                            presentTimedBrew = true
                        }) {
                            TeaCardView(brew: $brew, selectedCup: $selectedCup)
                                .chevronNavigation()
                        }
                        .listRowBackground(brew.theme.mainColor)
                        .swipeActions {
                            Button(role: .destructive) {
                                brewStore.removeTea(brew)
                            } label: {
                                Label("Delete", systemImage: Icon.delete)
                            }
                            
                            Button() {
                                editedTea = brew
                                presentEditBrew = true
                            } label: {
                                Label("Edit", systemImage: Icon.edit)
                            }
                            .tint(.blue)
                        }
                    }
                    .onDelete { indices in
                        brewStore.brews.remove(atOffsets: indices)
                    }
                }
                
            }
            .listStyle(.automatic)
            .listRowSpacing(10)
            .navigationTitle("Tea Dragon")
            .toolbar {
                // Settings Button (Left)
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape")
                    }
                }
                
                // Add Tea Button (Right)
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        presentAddBrew = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
                
            }
            
        }
        .fullScreenCover(isPresented: $presentAddBrew) {
            TeaAddView()
        }
        .fullScreenCover(item: $editedTea, content: { tea in
            TeaEditView(tea: tea)
        })
        .fullScreenCover(isPresented: $presentTimedBrew) {
            TeaBrewView(brew: $timedBrew)
        }
        .fullScreenCover(isPresented: $showLegalInfo) {
            PrivacyPolicyView()
        }
        .onChange(of: scenePhase) { beforePhase, newPhase in
            if newPhase == .inactive {
                saveAction?()
            }
        }
        
    }
}

#Preview {
    TeaListView().inject()
}

#Preview("Tea Themes") {
    let dataStore: DataStore = DataStore()
    TeaListView().inject(dataStore: dataStore)
        .onAppear {
            dataStore.loadColoredBrews()
        }
}
