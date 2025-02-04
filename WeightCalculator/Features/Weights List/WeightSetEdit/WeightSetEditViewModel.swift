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
    
    func saveChanges() {
        self.originalSet.updateWeightUnits(barbells: self.barbells, plates: self.plates)
        
        /*
        guard let realm = try? Realm() else { return }
        
        
        
        do {
            try realm.write {
//                if self.barbells != Array(self.originalSet.barbells) {
//                    self.originalSet.setValue(self.barbells, forKey: "barbells")
//                }
//                if self.plates != Array(self.originalSet.plates) {
//                    self.originalSet.setValue(self.plates, forKey: "plates")
//                }
//                self.originalSet.objectWillChange
//                withAnimation {
//                    self.originalSet = self.originalSet
//                }
            }
        } catch {
            fatalError()
        }*/
    }
    
//    func remove(_ objects: [ObjectBase]) {
//        guard let realm = try? Realm() else { return }
//        
//        Task {
//            do {
//                try await realm.asyncWrite {
//                    realm.delete(objects)
//                }
//            } catch {
//                fatalError()
//            }
//        }
//    }
//    
    
//    func saveChanges() {
//        if let thaw = self.originalSet.thaw(), let realm = thaw.realm {
//            Task {
//                try! realm.write {
//                    thaw.barbells = barbells
//                    thaw.plates = plates
//                    thaw.sort()
//                }
//            }
//        }
//    }
}
