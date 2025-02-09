//
//  WeightFinderViewModel.swift
//  WeightCalculator
//
//  Created by Вадим on 28.01.2025.
//

import SwiftUI
import RealmSwift
import Combine

@MainActor
class WeightFinderViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private var weightSet: WeightSet?
    var isWeightSetSelected: Bool {
        self.weightSet != nil
    }
    
    @Published var weightVariants: [WeightSet]?
    @Published var requiredWeight: Double?
    
    private var cancellables = Set<AnyCancellable>()
    
    
    // MARK: - Initializers
    
    init(userSettings: UserSettings) {        
        let realm = try? Realm()
        if let selectedWeightSetUUID = userSettings.selectedWeightSetUUID {
            self.weightSet = realm?.object(ofType: WeightSet.self, forPrimaryKey: selectedWeightSetUUID)
        }
        
        userSettings.$selectedWeightSetUUID.sink { uuid in
            if let uuid {
                self.weightSet = realm?.object(ofType: WeightSet.self, forPrimaryKey: uuid)
                self.weightVariants = nil
            } else {
                self.weightVariants = nil
                self.weightSet = nil
                self.requiredWeight = nil
            }
        }.store(in: &self.cancellables)
    }
    
    // MARK: - Flow funcs
    
    func findRequiredWeightSet() {
        guard let weightSet, let requiredWeight, requiredWeight > 0 else {
            self.weightVariants = nil
            return
        }
        
        let barbells = Array(weightSet.barbells).map({ $0.value })
        let plates = Array(weightSet.plates).map({ $0.value })
        
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


