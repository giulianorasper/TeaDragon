//
//  EditCupsView.swift
//  Tea Dragon
//
//  Created by Giuliano Rasper on 28.12.24.
//
import SwiftUI

struct EditCupsView: View {
    @EnvironmentObject var cupStore: CupStore
    @Environment(\.dismiss) var dismiss
    // TODO: Figure out why this breaks when using cup instances and directly modifying the Volumes millilitre attribute
//    @State private var newCup: Cup = Cup()
    @State private var cupName: String = ""
    @State private var intValue: Int = 0
    @State private var textValue: String = ""
    var body: some View {
        NavigationView {
            Form {
                    ForEach(cupStore.cups, id: \.id) { cup in
                        HStack {
                            Image(systemName: Icon.cup)
                            Text(cup.name)
                            Spacer()
                            Text(cup.volume.millilitres_string)
                            Text(cup.volume.unit())
                        }
                    }
                    .onDelete { indices in
                        cupStore.cups.remove(atOffsets: indices)
                    }
                    .deleteDisabled(cupStore.cups.count <= 1)
                    HStack {
                        Button(action: {
                            cupStore.cups.append(Cup(name: cupName, volume: Volume(millilitres: intValue)))
                            intValue = 0
                            textValue = ""
                            cupName = ""
                        }) {
                            Image(systemName: Icon.append)
                        }
//                        .disabled(!newCup.isValid)
                        .disabled(intValue <= 0)
                        TextField("Cup Name", text: $cupName)
                        Spacer()
                        TextField("250", text: $textValue)
                            .keyboardType(.numberPad) // Makes the keyboard more number-friendly
                                            .onChange(of: textValue) { oldValue, newValue in
                                                // Validate and update the intValue
                                                if let newInt = Int(newValue) {
                                                    intValue = newInt
                                                } else if newValue.isEmpty {
                                                    intValue = 0 // Default for empty input
                                                } else {
                                                    textValue = "\(intValue)" // Revert to previous valid value
                                                }
                                            }
                            .multilineTextAlignment(.trailing)
//                        Text(newCup.volume.unit())
                        Text("ml")
                    }
                
            }
            .navigationTitle("Cup Shelf")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
//                    .disabled(CupInfo.isEmpty)
                }
            }
        }
    }
}

#Preview {
    EditCupsView().inject()
}
