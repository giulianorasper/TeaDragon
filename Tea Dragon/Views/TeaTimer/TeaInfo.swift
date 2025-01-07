//
// TeaInfo.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 07.01.25.
//


import SwiftUI

struct TeaInfo: View {
    
    @Binding var tea: Tea
    
    var body: some View {
        
        Text(tea.teaName)
            .font(.title)
            .padding(.bottom, -5)
        Text(tea.cup.name)
            .foregroundStyle(.secondary)
            .font(.footnote)
            .padding(.bottom, 5)
        HStack {
            Tag(text: tea.temperature.formatted(), systemImage: Icon.temperature)
            Tag(text: tea.cup.volume.formatted(), systemImage: Icon.cup)
            Tag(text: tea.spoons.formatted(), systemImage: Icon.spoons)
        }
        
    }
}
