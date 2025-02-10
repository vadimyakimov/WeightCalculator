//
//  WeightUnit.swift
//  WeightCalculator
//
//  Created by Вадим on 10.02.2025.
//

import Foundation
import RealmSwift

class WeightUnit: Object, ObjectKeyIdentifiable, ExpressibleByFloatLiteral, Comparable {
    
    // MARK: - Properties
    
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var value: Double
    
    // MARK: - Initializers
    
    required convenience init(floatLiteral value: Double) {
        self.init()
        self.value = value
    }
    
    convenience init(_ value: Double) {
        self.init()
        self.value = value
    }
    
    // MARK: - Funcs
    
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
