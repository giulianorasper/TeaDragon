//
//  Imprint.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 05.01.25.
//

import SwiftUI

struct ImprintView : View {
    var body: some View {
        NavigationStack {
            List {
                
                Label(AppConstants.developerName, systemImage: "person.fill")
                Label {
                    Text(AppConstants.multilineAddress)
                } icon: {
                    Image(systemName: "location.fill")
                }
                Label(AppConstants.contactEmail, systemImage: "envelope.fill")
            }
        }
        .navigationTitle("Imprint")
        
    }
}


#Preview {
    ImprintView()
}
