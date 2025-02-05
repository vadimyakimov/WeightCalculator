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

//    let realm: Realm
    @ObservedResults(WeightSet.self) var weightSets
    
    init() {
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
//        self.weightSets.observe { _ in
//            
//        }
        return WeightSetsListViewModel(weightSets: self.weightSets)
    }
     
    
    func createWeightFinderViewModel() -> WeightFinderViewModel {
        return WeightFinderViewModel(weightSet: self.weightSets.last!)
    }
}
