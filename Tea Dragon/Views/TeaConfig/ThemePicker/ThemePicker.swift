//
//  TeaTypeSelector.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 30.12.24.
//
 
import SwiftUI

struct ThemePicker: View {
    @Binding var selection: Theme
    
    var body: some View {
        Picker(selection: $selection, label: EmptyView()) {
            ForEach(Theme.allCases) { theme in
                ThemeView(theme: theme)
                    .tag(theme)
            }
        }
        .labelsHidden()
        .pickerStyle(.navigationLink)
    }
}


#Preview {
    ThemePicker(selection: .constant(.greenTea))
}
