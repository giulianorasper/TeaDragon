//
//  TeaBrewView.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 29.12.24.
//
import SwiftUI
import AVFoundation

struct TeaBrewView: View {
    @Binding var show: Bool
    @Binding var brew: Tea
    @State private var isBrewDone: Bool = false
    
    
    var body: some View {
        
        NavigationStack {
            GeometryReader { geometry in
                let sideLength = min(geometry.size.width, geometry.size.height)
                VStack {
                    Spacer()
                    Rectangle()
                        .foregroundStyle(brew.theme.mainColor)
                        .cornerRadius(20)
                        .frame(maxWidth: sideLength * 0.7, maxHeight: sideLength * 0.7)
                    
                        .overlay {
                            Image(systemName: Icon.cupWarm)
                                .font(.system(size: sideLength * 0.5))
                                .foregroundStyle(brew.theme.accentColor)
                        }
                    Spacer()
                    
                    
                    TeaInfo(tea: $brew)
                    Spacer()
                    BrewProgressControllerView(brew: $brew)
                    
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            
                            show = false
                        }) {
                            if isBrewDone {
                                Image(systemName: "chevron.left")
                                
                                
                            } else {
                                Image(systemName: "xmark")
                            }
                        }
                    }
                }
            }
        }}
}

#Preview {
    @Previewable @State var brew: Tea = Tea.sampleData[0]
    TeaBrewView(show: .constant(true), brew: $brew)
}
