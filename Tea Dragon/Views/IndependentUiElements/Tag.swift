//
//  Tag.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 07.01.25.
//
import SwiftUI

struct Tag: View {
    var text: String
    var systemImage: String
    
    init(text: String, systemImage: String) {
        self.text = text
        self.systemImage = systemImage
    }
    
    var body: some View {
        Label(text, systemImage: systemImage)
            .padding(.horizontal, 5)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(5)
    }
}
