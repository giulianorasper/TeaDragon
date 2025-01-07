//
//  TeaTypePicker.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 30.12.24.
//
 
import SwiftUI

struct TeaTypePicker: View {
    @Binding var selection: TeaType
    
    var body: some View {
        Picker(selection: $selection, label: EmptyView()) {
            ForEach(TeaType.allCases) { theme in
                TeaTypeView(theme: theme)
                    .tag(theme)
            }
        }
        .labelsHidden()
        .pickerStyle(.navigationLink)
    }
}


#Preview {
    TeaTypePicker(selection: .constant(.greenTea))
}
