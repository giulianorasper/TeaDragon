//
//  ThemeView.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 30.12.24.
//

import SwiftUI

struct TeaTypeView: View {
    let theme: TeaType
    
    var body: some View {
        Text(theme.name)
            .padding(4)
            .background(theme.mainColor)
            .foregroundColor(theme.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        TeaTypeView(theme: .greenTea)
    }
}
