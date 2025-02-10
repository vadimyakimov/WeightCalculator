//
//  WeightSetEditSection.swift
//  WeightCalculator
//
//  Created by Вадим on 25.01.2025.
//

import SwiftUI
import RealmSwift

struct WeightSetEditSectionView: View {
    
    // MARK: - Properties
    
    @Binding var weights: [WeightUnit]
    let title: String
    
    @FocusState var focusedField: UUID?
    let newWeightFieldID: UUID
    @State var hasJustAddedNewWeight: Bool = false
    
    @State private var newWeight: Double? = nil
    
    // MARK: - body
    
    var body: some View {
        Section {
            // Saved weights
            ForEach(self.$weights) { weight in
                TextField("Edit", value: weight.value, format: .number)
                    .keyboardType(.decimalPad)
                    .focused(self.$focusedField, equals: weight.wrappedValue.id)
                    .onAppear {
                        if self.hasJustAddedNewWeight {
                            self.focusedField = weight.wrappedValue.id
                            self.hasJustAddedNewWeight.toggle()
                        }
                    }
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
                    self.newWeight = nil
                    self.hasJustAddedNewWeight = true
                }
            
        } header: {
            Text(self.title)
        }
    }
    
    // MARK: - Initializer
    
    init(weights: Binding<[WeightUnit]>, title: String, focusedField: FocusState<UUID?>, newWeightFieldID: UUID) {
        self._weights = weights
        self.title = title
        self._focusedField = focusedField
        self.newWeightFieldID = newWeightFieldID
    }
    
}

