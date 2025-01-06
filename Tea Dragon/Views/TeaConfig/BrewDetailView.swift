//
//  NewEditBrewView.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 26.12.24.
//
import SwiftUI

struct BrewDetailView: View {
    @Binding var brew: Brew
    @State private var selectedTime = Date()
    
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Steep Settings")) {
                    HStack {
                        Label("Tea Name", systemImage: Icon.teaName)
                        Spacer()
                        TextField("Tea Name", text: $brew.teaName)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Label("Tea Type", systemImage: Icon.teaType)
                        ThemePicker(selection: $brew.theme)
    
                    }
                    HStack {
                        Label("Temperature", systemImage: Icon.temperature)
                        TemperaturePicker(selection: $brew.temperature)
                                        .keyboardType(.numberPad)
                    }
                    HStack {
                        Label("Cup", systemImage: Icon.cup)
                        Spacer()
                        CupPicker(selection: $brew.cup)
                    }
                    
                    HStack {
                        Label("Tea Quantity", systemImage: Icon.spoons)
                        SpoonPicker(selection: $brew.spoons)
                    }
                }
                
                Section(header: Text("Infusision Times")) {
                    ForEach(Array(brew.brewTimes.enumerated()), id: \.0) { index, time in
                        TimerPicker(number: index + 1, selectedTime: $brew.brewTimes[index])
                    }
                            .onDelete { indices in
                                brew.brewTimes.remove(atOffsets: indices)
                            }
                            .deleteDisabled(brew.brewTimes.count <= 1)
                    HStack(alignment: .center) {
                        Button(action: {
                            brew.brewTimes.append(brew.brewTimes[brew.brewAmount - 1]  + TimePeriod(minutes: 0, seconds: 30))
                        }) {
                            Image(systemName: Icon.append)  
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        BrewDetailView(brew: .constant(Brew.sampleData[0])).inject()
    }
}
