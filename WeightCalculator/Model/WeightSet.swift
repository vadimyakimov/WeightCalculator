//
//  WeightSet.swift
//  WeightCalculator
//
//  Created by Вадим on 15.01.2025.
//

import Foundation
import RealmSwift

class WeightSet: Object, ObjectKeyIdentifiable {
    
    // MARK: - Properties
    
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var barbells: RealmSwift.List<WeightUnit>
    @Persisted var plates: RealmSwift.List<WeightUnit>
    
    var isEmpty: Bool {
        self.barbells.isEmpty && self.plates.isEmpty
    }
    
    // MARK: - Initializer
    
    convenience init(barbells: [WeightUnit] = [], plates: [WeightUnit] = []) {
        self.init()
        self.barbells.append(objectsIn: barbells)
        self.plates.append(objectsIn: plates)
        self.barbells.sort(by: > )
        self.plates.sort(by: > )
    }
    
    // MARK: - Funcs
    
    override class func primaryKey() -> String? {
        "id"
    }
}
