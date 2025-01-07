//
//  ContentView.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 06.12.24.
//

import SwiftUI

struct TeaListView: View {
    @EnvironmentObject var brewStore: TeaStore
    @State var presentAddBrew: Bool = false
    @State var editedBrewIndex: Int = 0
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
                    ForEach(Array($brewStore.brews.enumerated()), id: \.element.id) { index, $brew in
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
                                Label("Delete", systemImage: "trash")
                            }
                            
                            Button() {
                                editedBrewIndex = index
                                presentEditBrew = true
                            } label: {
                                Label("Edit", systemImage: "pencil")
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
                // Add Edit Button (Lower Right)
                
                                // Legal Information Button (Left)
                ToolbarItem(placement: .navigationBarLeading) {
                                    NavigationLink(destination: SettingsView()) {
                                        Image(systemName: "gearshape")
                                    }
                                }

                                // Add Brew Button (Right)
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
            NavigationStack {
                TeaEditView(show: $presentEditBrew, brew: $brewStore.brews[editedBrewIndex])
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
    let brewStore: TeaStore = TeaStore()
    TeaListView().inject(brewStore: brewStore)
        .onAppear {
            brewStore.loadColoredBrews()
        }
}
