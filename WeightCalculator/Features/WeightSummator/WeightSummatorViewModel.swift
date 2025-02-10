//
//  WeightSummatorViewModel.swift
//  WeightCalculator
//
//  Created by Вадим on 07.02.2025.
//

import RealmSwift
import Combine

class WeightSummatorViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var weightSet: WeightSet?
    
    @Published var weightSum: Double = 0
    @Published var selectedWeightIndices: Set<Int> = []
    
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
            } else {
                self.weightSet = nil
            }
            self.weightSum = 0
            self.selectedWeightIndices = []
        }.store(in: &self.cancellables)             
    }
    
    // MARK: - Funcs
    
    func onTap(weights: [WeightUnit]) {
        self.weightSum = 0
        for weight in weights {
            self.weightSum += weight.value
        }
    }
    
    
    
}
