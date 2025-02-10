//
//  ContentViewModel.swift
//  WeightCalculator
//
//  Created by Вадим on 22.01.2025.
//

import RealmSwift

@MainActor
class ContentViewModel {
    
    // MARK: - Properties
    
    @ObservedResults(WeightSet.self) var weightSets    
    let userSettings = UserSettings()
    
    // MARK: - Funcs
    
    func createWeightSetsListViewModel() -> WeightSetsListViewModel {
        return WeightSetsListViewModel(weightSets: self.weightSets, userSettings: self.userSettings)
    }
    
    func createWeightFinderViewModel() -> WeightFinderViewModel {
        return WeightFinderViewModel(userSettings: self.userSettings)
    }    
    
    func createWeightSummatorViewModel() -> WeightSummatorViewModel {
        return WeightSummatorViewModel(userSettings: self.userSettings)
    }
}
