//
//  WeightFinderViewModel.swift
//  WeightCalculator
//
//  Created by Вадим on 28.01.2025.
//

import SwiftUI

class WeightFinderViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let weightSet: WeightSet
    
    @Published var weightVariants: [WeightSet]?
    
    // MARK: - Initializers
    
    init(weightSet: WeightSet) {
        self.weightSet = weightSet
    }
    
    // MARK: - Flow funcs
    
    func findRequiredWeightSet(for requiredWeight: Double?) {
        guard let requiredWeight, requiredWeight > 0 else {
            self.weightVariants = nil
            return
        }
        
        let barbells = self.weightSet.barbells.map({ $0.value })
        let plates = self.weightSet.plates.map({ $0.value })
        
        var weightVariants: [WeightSet] = []
        
        for barbell in barbells {
            guard !weightVariants.contains(where: { $0.barbells.contains(where: { $0.value == barbell }) }),    // Check if there is variant with the same barbell
                  let plateVariants = self.findRequiredPlates(for: requiredWeight - barbell, weightSet: plates) // Check if there is suitable plates for this barbell
            else { continue }
            
            for plateVariant in plateVariants {
                let barbellUnit = WeightUnit(barbell)
                let plateUnits = plateVariant.map({ WeightUnit($0) })
                let weightSet = WeightSet(barbells: [barbellUnit], plates: plateUnits)
                weightVariants.append(weightSet)
            }
        }
        
        self.weightVariants = weightVariants
    }
    
    private func findRequiredPlates(for requiredWeight: Double, weightSet: [Double]) -> [[Double]]? {
        guard requiredWeight > 0 else { return nil }
        
        var weightSet = weightSet
        var weightVariants: [[Double]] = []
        let epsilon = 1e-10
        
        for weight in weightSet {
            weightSet.removeFirst()
            
            if abs(weight - requiredWeight) < epsilon {
                guard !weightVariants.contains([weight]) else { continue } // Check if there is the same variant
                weightVariants.append([weight])
            } else if weight < requiredWeight {
                guard let restWeightVariants = self.findRequiredPlates(for: requiredWeight - weight,
                                                                       weightSet: weightSet) // Keep searching suitable weights to compose with current
                else { continue }
                
                for restWeightVariant in restWeightVariants {
                    let weightVariant = [weight] + restWeightVariant
                    guard !weightVariants.contains(weightVariant) else { continue } // Check if there is the same variant
                    weightVariants.append(weightVariant)
                }
            }
        }
        
        guard !weightVariants.isEmpty else { return nil }
        return weightVariants
    }
    
    
}

