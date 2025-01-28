//
//  WeightSetEditView.swift
//  WeightCalculator
//
//  Created by Вадим on 27.01.2025.
//

import SwiftUI

class WeightSetEditViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Binding private var originalSet: WeightSet
    
    @Published var barbells: [WeightUnit]
    @Published var plates: [WeightUnit]
    
    let newBarbellFieldID = UUID()
    let newPlateFieldID = UUID()
    
    var UUIDIndexDictionary: [UUID : Int] {
        let barbellsUUIDs = self.barbells.map({ $0.id })
        let platesUUIDs = self.plates.map({ $0.id })
        var fieldsUUIDList = barbellsUUIDs
        fieldsUUIDList.append(self.newBarbellFieldID)
        fieldsUUIDList.append(contentsOf: platesUUIDs)
        fieldsUUIDList.append(self.newPlateFieldID)
        return Dictionary(uniqueKeysWithValues: fieldsUUIDList.enumerated().map({ ($1, $0) }))
    }
    var firstUUID: UUID? {
        self.barbells.first?.id
    }
    var lastUUID: UUID {
        self.newPlateFieldID
    }
    
    // MARK: - Initializer
    
    init(weightSet: Binding<WeightSet>) {
        self._originalSet = weightSet
        self.barbells = weightSet.wrappedValue.barbells
        self.plates = weightSet.wrappedValue.plates    
    }
    
    // MARK: - Flow funcs
    
    func saveChanges() {
        self.originalSet.barbells = self.barbells
        self.originalSet.plates = self.plates
        self.originalSet.sort()        
        self.originalSet = self.originalSet
    }
}
