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
    let userSettings = UserSettings()
        
    init() {
//        self.userSettings.selectedWeightSetUUID = nil
//        UserDefaults.standard.object(forKey: "selectedWeightSet")
//        UserDefaults.standard.set(UUID(), forKey: "selectedWeightSet")
        
//        let realm = try! Realm()
//        self.weightSets = realm.objects(WeightSet.self)
        
//        self.$weightSets.append(WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]))
//        self.$weightSets.append(WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]))
//        self.$weightSets.append(WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]))
//        self.$weightSets.append(WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]))
//        self.$weightSets.append(WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]))
    }
    
    
//    private func loadData() -> Results<WeightSet>? {
//        guard let realm = try? Realm() else { return nil }
//        return realm.objects(WeightSet.self)
//    }
    
    func createWeightSetsListViewModel() -> WeightSetsListViewModel {
        return WeightSetsListViewModel(weightSets: self.weightSets, userSettings: self.userSettings)
    }
    
    func createWeightFinderViewModel() -> WeightFinderViewModel {
//        let realm = self.weightSets.realm
//        var weightSet: WeightSet? = nil
//        if let selectedWeightSetUUID = self.userSettings.selectedWeightSetUUID {
//            weightSet = realm?.object(ofType: WeightSet.self, forPrimaryKey: selectedWeightSetUUID)
//        }
        return WeightFinderViewModel(userSettings: self.userSettings)
    }
    
    
    func createWeightSummatorViewModel() -> WeightSummatorViewModel {
        return WeightSummatorViewModel(userSettings: self.userSettings)
    }
}
