//
//  WeightSetEditSection.swift
//  WeightCalculator
//
//  Created by Вадим on 25.01.2025.
//

import SwiftUI

struct WeightSetEditSectionView: View {
        
    @Binding var weights: [WeightUnit]
    let title: String
    
    @FocusState var focusedField: UUID?
    let newWeightFieldID: UUID
    
    @State var newWeight: Double? = nil    
    
    var body: some View {
        Section {
                // Saved weights
                ForEach(self.$weights) { weight in
                    TextField("Edit", value: weight.value, format: .number)
                        .keyboardType(.decimalPad)
                        .focused(self.$focusedField, equals: weight.id)
                }
                .onDelete { indexSet in
                    self.weights.remove(atOffsets: indexSet)
                }
                
                
                // Text field for new weight
                TextField("New Weight", value: self.$newWeight, format: .number)
                    .keyboardType(.decimalPad)
                    .focused(self.$focusedField, equals: self.newWeightFieldID)
                    .onChange(of: self.newWeight) { newValue in
                        guard let newValue else { return }
                        let newWeightUnit = WeightUnit(newValue)
                        self.weights.append(newWeightUnit)
                        self.focusedField = self.weights.last?.id
                        self.newWeight = nil
                    }
            
        } header: {
            Text(self.title)
        }
        
        
    }
}

