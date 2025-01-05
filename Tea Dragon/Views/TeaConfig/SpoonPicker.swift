//
//  TemperaturePicker.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 27.12.24.
//

import SwiftUI

struct SpoonPicker: View {
    @Binding var selection: Spoon
    
    var body: some View {
        Picker("", selection: $selection) {
            ForEach(Array(stride(from: 0.5, through: 10.0, by: 0.5)), id: \.self) { half_spoons in
                let spoon = Spoon(amount: Double(half_spoons))
                Text(spoon.formatted()).tag(spoon)
            }
        }
        .pickerStyle(.menu)
    }
}
