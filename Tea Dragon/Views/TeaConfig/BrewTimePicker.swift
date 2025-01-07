//
//  BrewTimePicker.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 26.12.24.
//

import SwiftUI

struct BrewTimePicker: View {
    let number: Int
    @Binding var selectedTime: TimePeriod
    @State var showPopover: Bool = false
    
    var body: some View
    {
        HStack {
            Label("\(number). Steep", systemImage: Icon.steep)
            
            Spacer()
            
            Button(action: { showPopover.toggle() }) {
                HStack {
                    Text(selectedTime.formatTime())
                    Image(systemName: Icon.time)
                }
            }
            .popover(isPresented: $showPopover, content: {
                DualWheelPicker(timePeriod: $selectedTime)
                    .presentationCompactAdaptation((.popover))
                    .frame(width: 200, height: 150)
            })
            
        }
        .padding(1)
    }
}
