//
//  ContentViewModel.swift
//  WeightCalculator
//
//  Created by Вадим on 22.01.2025.
//

import RealmSwift
import SwiftUI

@MainActor
class ContentViewModel {

    @ObservedResults(WeightSet.self) var weightSets
    
    init() {
//        self.$weightSets.append(WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]))
//        self.$weightSets.append(WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]))
//        self.$weightSets.append(WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]))
//        self.$weightSets.append(WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]))
//        self.$weightSets.append(WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]))
//        self.$weightSets.append(WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]))
//        self.$weightSets.append(WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]))
//        self.$weightSets.append(WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]))
//        self.$weightSets.append(WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]))
//        self.$weightSets.append(WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]))
//        self.$weightSets.append(WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]))
//        self.$weightSets.append(WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]))
//        self.$weightSets.append(WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]))
//        self.$weightSets.append(WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]))
//        self.$weightSets.append(WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]))
//        self.$weightSets.append(WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]))
//        self.$weightSets.append(WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]))
//        self.$weightSets.append(WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]))
//        self.$weightSets.append(WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]))
//        self.$weightSets.append(WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]))
    }
    
    func createWeightSetsListViewModel() -> WeightSetsListViewModel {
        return WeightSetsListViewModel()
    }
     
    
    func createWeightFinderViewModel() -> WeightFinderViewModel {
        return WeightFinderViewModel(weightSet: self.weightSets.last!)
    }
}
