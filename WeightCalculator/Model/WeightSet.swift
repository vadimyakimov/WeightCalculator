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
        self.barbells.sort(by: > )
        self.plates.sort(by: > )
    }
    
    override class func primaryKey() -> String? {
        "id"
    }
    
//    func updateWeightUnits(barbells: [WeightUnit], plates: [WeightUnit]) {
//        if barbells.isEmpty && plates.isEmpty,
//           let realm = self.realm {
//            try? realm.write {
//                realm.delete(self)
//                
//            }
//        }
//        self.update(self.barbells, with: barbells)
//        self.update(self.plates, with: plates)
//    }
//    
//    private func update(_ originalList: List<WeightUnit>, with newArray: [WeightUnit]) {
//        guard let realm = self.realm else { return }
//        
//        let oldArray = Array(originalList)
//        
//        if newArray != oldArray {
//            
//            let newSet = Set(newArray.map { $0.id })
//            let objectsToDelete = originalList.filter { !newSet.contains($0.id) }
//            
//            var sortedNewArray = newArray.sorted(by: > )
//            
//            try? realm.write {
//                realm.delete(objectsToDelete)
//                originalList.removeAll()
//                originalList.append(objectsIn: sortedNewArray)
//            }
//        }
//        
//    }
    
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
