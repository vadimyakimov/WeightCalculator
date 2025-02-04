//
//  WeightSet.swift
//  WeightCalculator
//
//  Created by Вадим on 15.01.2025.
//

import Foundation
import RealmSwift

class WeightSet: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var barbells: List<WeightUnit>
    @Persisted var plates: List<WeightUnit>
    
    var isEmpty: Bool {
        self.barbells.isEmpty && self.plates.isEmpty
    }
    
    convenience init(barbells: [WeightUnit] = [], plates: [WeightUnit] = []) {
        self.init()
        self.barbells.append(objectsIn: barbells)
        self.plates.append(objectsIn: plates)
        self.sort()
    }
    
    override class func primaryKey() -> String? {
        "id"
    }
    
    func sort() {
        self.barbells.sort(by: > )
        self.plates.sort(by: > )
    }
    
    func updateWeightUnits(barbells: [WeightUnit], plates: [WeightUnit]) {
        self.update(self.barbells, with: barbells)
        self.update(self.plates, with: plates)
        
//        if self.isEmpty {
//            try? self.realm?.write {
//                self.realm?.delete(self)
//            }
//        }
    }
    
    private func update(_ originalList: List<WeightUnit>, with newArray: [WeightUnit]) {
        guard let realm = self.realm else { return }
        
        let oldArray = Array(originalList)
        
        if newArray != oldArray {
            try? realm.write {
                let newSet = Set(newArray.map { $0.id })
                let objectsToDelete = originalList.filter { !newSet.contains($0.id) }
                realm.delete(objectsToDelete)
                
                originalList.removeAll()
                originalList.append(objectsIn: newArray)                
            }
        }
        
    }
    
}

class WeightUnit: Object, ObjectKeyIdentifiable, ExpressibleByFloatLiteral, Comparable {
        
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var value: Double
        
    required convenience init(floatLiteral value: Double) {
        self.init()
        self.value = value
    }
    
    convenience init(_ value: Double) {
        self.init()
        self.value = value
    }
    
    override class func primaryKey() -> String? {
        "id"
    }
    
    static func < (lhs: WeightUnit, rhs: WeightUnit) -> Bool {
        lhs.value < rhs.value
    }
    
    static func == (lhs: WeightUnit, rhs: WeightUnit) -> Bool {
        lhs.value == rhs.value
    }
}
