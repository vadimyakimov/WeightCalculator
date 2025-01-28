//
//  WeightSet.swift
//  WeightCalculator
//
//  Created by Вадим on 15.01.2025.
//

import Foundation

class WeightSet: Identifiable, ObservableObject {
    
    let id = UUID()
    @Published var barbells: [WeightUnit]
    @Published var plates: [WeightUnit]
    
    init(barbells: [WeightUnit] = [], plates: [WeightUnit] = []) {
        self.barbells = barbells
        self.plates = plates
//        self.sort()
    }
    
    func sort() {
//        self.barbells = self.barbells.sorted(by: ({ $0.value > $1.value }))
//        self.plates = self.plates.sorted(by: ({ $0.value > $1.value }))
//        self.barbells.sort(by: ({ $0.value > $1.value }))
//        self.plates.sort(by: ({ $0.value > $1.value }))
        self.barbells.sort()
        self.plates.sort()
    }
}

class WeightUnit: Identifiable, ExpressibleByFloatLiteral, Comparable {
        
    let id = UUID()
    var value: Double
    
    required init(floatLiteral value: Double) {
        self.value = value
    }
    
    init(_ value: Double) {
        self.value = value
    }
    
    static func < (lhs: WeightUnit, rhs: WeightUnit) -> Bool {
        lhs.value < rhs.value
    }
    
    static func == (lhs: WeightUnit, rhs: WeightUnit) -> Bool {
        lhs.value == rhs.value
    }
}
