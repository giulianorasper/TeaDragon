//
//  TemperaturePicker.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 27.12.24.
//

import SwiftUI

struct TemperaturePicker: View {
    @Binding var selection: Temperature
    
    var body: some View {
        Picker("", selection: $selection) {
            ForEach(1...100, id: \.self) { celsius in
                let temperature = Temperature(celsius: Double(celsius))
                Text(temperature.formatted()).tag(temperature)
            }
        }
        .pickerStyle(.menu)
    }
}

struct TemperaturePicker_Previews: PreviewProvider {
    static var previews: some View {
        TemperaturePicker(selection: .constant(Temperature(celsius: 0.0)))
    }
}
