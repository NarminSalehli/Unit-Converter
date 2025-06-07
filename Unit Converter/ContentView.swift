//
//  ContentView.swift
//  Unit Converter
//
//  Created by Nərmin Salehli on 07.06.25.
//

import SwiftUI

struct ContentView: View {
    @State private var enteredNumber = 0.0
    @State private var inputUnits = 1
    @State private var outputUnits = 2
    
    @FocusState private var unitIsFocused: Bool
    
    let nameUnits = ["m", "km", "fut", "yard", "mil"]
    
    var result: Double {
        let inputInMeter: Double
        switch inputUnits {
        case 0: inputInMeter = enteredNumber
        case 1: inputInMeter = enteredNumber * 1000
        case 2: inputInMeter = enteredNumber * 0.3048
        case 3: inputInMeter = enteredNumber * 0.9144
        case 4: inputInMeter = enteredNumber * 1609.34
        default: inputInMeter = 0
        }
        
        switch outputUnits {
        case 0: return inputInMeter
        case 1: return inputInMeter / 1000
        case 2: return inputInMeter / 0.3048
        case 3: return inputInMeter / 0.9144
        case 4: return inputInMeter / 1609.34
        default: return 0
        }
    }
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Enter a number", value: $enteredNumber, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($unitIsFocused)
                }
                Section("ENTER INPUT UNITS") {
                    Picker("Input Number", selection: $inputUnits) {
                        ForEach(0..<nameUnits.count, id: \.self) {
                            Text(nameUnits[$0])
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("ENTER OUTPUT UNITS") {
                    Picker("Output units", selection: $outputUnits) {
                        ForEach(0..<nameUnits.count, id: \.self) {
                            Text(nameUnits[$0])
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("RESULT") {
                    Text("\(result, specifier: "%.2f")  \(nameUnits[outputUnits])")
                }
            }
            .navigationTitle("Unit Converter")
            
            .toolbar {
                if unitIsFocused {
                    Button("Done") {
                        unitIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
