//
//  Untitled.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 30.12.24.
//

import SwiftUI

struct ChevronNavigationModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        HStack {
            content
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
    }
}

extension View {
    func chevronNavigation() -> some View {
        self.modifier(ChevronNavigationModifier())
    }
}
