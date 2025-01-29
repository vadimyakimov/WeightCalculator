//
//  ContentViewModel.swift
//  WeightCalculator
//
//  Created by Вадим on 22.01.2025.
//

import SwiftUI



class ContentViewModel: ObservableObject {
    
    @Published var weightSets: [WeightSet] = [
        WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]),
        WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]),
        WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]),
    ]
    var selectedWeightSet: WeightSet = WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8, ])
    
    func createWeightSetsListViewModel() -> WeightSetsListViewModel {
        return WeightSetsListViewModel(weightSets: self._weightSets)
    }
    
    func createWeightFinderViewModel() -> WeightFinderViewModel {
        return WeightFinderViewModel(weightSet: self.selectedWeightSet)
    }
}
