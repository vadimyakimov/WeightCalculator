//
//  WeightSetEditView.swift
//  WeightCalculator
//
//  Created by Вадим on 27.01.2025.
//

import Foundation
import RealmSwift
import SwiftUI

@MainActor
class WeightSetEditViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Binding private var originalSet: WeightSet
    
    var barbells: [WeightUnit]
    var plates: [WeightUnit]
    
    // MARK: UUIDs for switching focus between text fields
    
    let newBarbellFieldID = UUID()
    let newPlateFieldID = UUID()
    
    var UUIDIndexDictionary: [UUID : Int] {
        let barbellsUUIDs = Array(self.barbells).map({ $0.id })
        let platesUUIDs = Array(self.plates).map({ $0.id })
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
        self.barbells = Array(weightSet.wrappedValue.barbells)
        self.plates = Array(weightSet.wrappedValue.plates)
    }
    
    // MARK: - Flow funcs
    
    func saveChanges() async {
        if self.barbells.isEmpty && self.plates.isEmpty,
           let realm = self.originalSet.realm {
            try? await realm.asyncWrite {
                realm.delete(self.originalSet)
            }
        } else {
            await self.update(self.originalSet.barbells, with: self.barbells)
            await self.update(self.originalSet.plates, with: self.plates)
        }
    }
    
    private func update(_ originalList: RealmSwift.List<WeightUnit>, with newArray: [WeightUnit]) async {
        
        let oldArray = Array(originalList)
        guard let realm = self.originalSet.realm, oldArray != newArray else { return }
        
        let nonZeroNewArray = newArray.compactMap { $0.value > 0 ? $0 : nil }
        let sortedNewArray = nonZeroNewArray.sorted(by: > )
        
        let newSet = Set(newArray.map { $0.id })
        let objectsToDelete = originalList.filter { !newSet.contains($0.id) }
        
        try? await realm.asyncWrite {
            realm.delete(objectsToDelete)
            originalList.removeAll()
            originalList.append(objectsIn: sortedNewArray)
        }
        
    }
}
