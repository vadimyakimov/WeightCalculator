//
//  WeightSet.swift
//  WeightCalculator
//
//  Created by Вадим on 15.01.2025.
//

//import SwiftUI
import Foundation
import RealmSwift

class WeightSet: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var barbells: RealmSwift.List<WeightUnit>
    @Persisted var plates: RealmSwift.List<WeightUnit>
    
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
}

class WeightUnit: Object, ObjectKeyIdentifiable, ExpressibleByFloatLiteral, Comparable {
        
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var value: Double
    var isSelected: Bool = false
    {
        didSet {
            print(isSelected)
        }
    }
        
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
