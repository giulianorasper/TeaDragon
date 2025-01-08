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
//    @State var editedBrewId: UUID? = UUID()
    @State var presentEditBrew: Bool = false
    @State var timedBrew: Tea = Tea()
    @State var presentTimedBrew: Bool = false
    @State var presentNewBrew: Bool = false
    @State var selectedCup: Cup = Cup.automaticCup
    @State var showLegalInfo: Bool = false
    @Environment(\.scenePhase) private var scenePhase
    var saveAction: (()->Void)?
    
    var body: some View {
        // TODO: check how dataflow works in this case and why this does not work when editedBrewID is a state
        var editedBrewId: UUID? = UUID()
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
                                if let index = brewStore.brews.firstIndex(where: { $0.id == brew.id }) {
                                    brewStore.brews.remove(at: index)
                                }
                            } label: {
                                Label("Delete", systemImage: Icon.delete)
                            }
                            
                            Button() {
                                editedBrewId = brew.id
                                print("update")
                                print(editedBrewId?.uuidString)
                                presentEditBrew = true
                            } label: {
                                Label("Edit", systemImage: Icon.edit)
//                                Text(brew.id.uuidString)
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
            TeaAddView(show: $presentAddBrew)
        }
        .fullScreenCover(isPresented: $presentEditBrew) {
            if let id = editedBrewId {
                let brewIndex: Int = brewStore.brews.firstIndex(where: { $0.id == id }) ?? 0
                NavigationStack {
                    TeaEditView(show: $presentEditBrew, brew: $brewStore.brews[brewIndex])
                }
                .onAppear {
                    print(id.uuidString)
                }
            }
        }
        .fullScreenCover(isPresented: $presentTimedBrew) {
            TeaBrewView(show: $presentTimedBrew, brew: $timedBrew)
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
