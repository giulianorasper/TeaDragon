//
//  CupPicker.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 27.12.24.
//

import SwiftUI

struct CupPicker: View {
    @Binding var selection: Cup
    @EnvironmentObject var cupStore: CupStore
    @State private var showAddCupDialog = false
    var allowAutomaticSelection: Bool = false
    
    var body: some View {
        let isAutomaticCup = Cup.automaticCup == selection
        let style = isAutomaticCup ? AnyShapeStyle(LinearGradient.magic) : AnyShapeStyle(.accent)
        
        HStack {
            Menu(selection.info) {
                if allowAutomaticSelection {
                    Button(Cup.automaticCup.name) {
                        selection = Cup.automaticCup
                    }
                }
                
                ForEach(cupStore.cups) { cup in
                    Button(cup.info) {
                        selection = cup
                    }
                    
                }
                Button(action: { showAddCupDialog.toggle() }) {
                    Label("Cup Shelf", systemImage: Icon.edit)
                }
            }
            .foregroundStyle(style)
            
            Image(systemName: Icon.selectChevron)
                .foregroundStyle(Color.accentColor)
                .font(.footnote)
        }
        .fullScreenCover(isPresented: $showAddCupDialog) {
            CupEditView()
        }
        .menuOrder(.fixed)
    }
}


struct CupPicker_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var cupStore: CupStore = CupStore()
        CupPicker(selection: .constant(Cup.sampleData[0]))
            .environment(cupStore)
    }
}
