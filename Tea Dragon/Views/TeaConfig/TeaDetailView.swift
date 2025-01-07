//
//  NewEditBrewView.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 26.12.24.
//
import SwiftUI

struct TeaDetailView: View {
    @Binding var brew: Tea
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
                        TeaTypePicker(selection: $brew.theme)
                        
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
                
                Section(header: Text("Infusion Times")) {
                    ForEach(Array(brew.brewTimes.enumerated()), id: \.0) { index, time in
                        BrewTimePicker(number: index + 1, selectedTime: $brew.brewTimes[index])
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
        TeaDetailView(brew: .constant(Tea.sampleData[0])).inject()
    }
}
