//
//  WeightSetsListViewModel.swift
//  WeightCalculator
//
//  Created by Вадим on 22.01.2025.
//

import SwiftUI
import Combine

class WeightSetsListViewModel: ObservableObject {
    @Published var weightSets: [WeightSet]
    
    init(weightSets: Published<[WeightSet]>) {
        self._weightSets = weightSets
    }
    
    func createWeightSetEditViewModel(for weightSet: Binding<WeightSet>) -> WeightSetEditViewModel {
         return WeightSetEditViewModel(weightSet: weightSet)
    }
        
}
