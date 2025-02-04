//
//  WeightSetsListViewModel.swift
//  WeightCalculator
//
//  Created by Вадим on 22.01.2025.
//

import SwiftUI
import RealmSwift

@MainActor
class WeightSetsListViewModel: ObservableObject {
        
    @Published var weightSets: [WeightSet] = []
    var token: NotificationToken?
    
    init() {
        guard let weightSetResults = self.loadData() else { return }
        
        self.weightSets = Array(weightSetResults)
        self.token = self.createNotificationToken(for: weightSetResults)
    }
    
    func loadData() -> Results<WeightSet>? {
        guard let realm = try? Realm() else { return nil }
        let weightSets = realm.objects(WeightSet.self)
           
        return weightSets
    }
    
    func createNotificationToken(for object: Results<WeightSet>) -> NotificationToken {
        let token = object.observe { changes in
            switch changes {
            case .update(let weightSetResults, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                
                print(deletions, insertions, modifications)
                
//                let deletionsIndexSet = IndexSet(deletions)
//                self.weightSets.remove(atOffsets: deletionsIndexSet)
                
//                let insertionsIndexSet = IndexSet(insertions)
//                self.weightSets.remove(atOffsets: deletionsIndexSet)
                
//                let modificationsIndexSet = IndexSet(modifications)
                for index in modifications {
                    if self.weightSets[index].isEmpty {
                        self.remove(index)
                    }
                    
                }
                
                self.objectWillChange.send()
            default: break
            }
        }
        
        return token
    }
    
//    func remove(_ indexSet: IndexSet) {
//        guard let realm = try? Realm() else { return }
//        
//        var objects = [WeightSet]()
//        
//        withAnimation {
//            objects = indexSet.compactMap { index -> WeightSet? in
//                guard index < self.weightSets.count else { return nil }
//                let object = self.weightSets.remove(at: index)
//                return object.isInvalidated ? nil : object
//            }
//        }
//        
//        do {
//            try realm.write {
//                realm.delete(objects)
//            }
//        } catch {
//            fatalError()
//        }
//    }
    
//    func remove(_ object: WeightSet) {
//        guard let realm = object.realm else { return }
//        
//        do {
//            try realm.write {
//                realm.delete(object)
//            }
//        } catch {
//            fatalError()
//        }
//    }
    
    func remove(_ index: Int) {
        guard let object = self.weightSets[safe: index],
            let realm = object.realm else { return }
        
            do {
                try realm.write {
                    realm.delete(object)
                    self.weightSets.remove(at: index)
                }
            } catch {
                fatalError()
            }
    }
        
    func createWeightSetEditViewModel(for weightSet: Binding<WeightSet>) -> WeightSetEditViewModel {
         return WeightSetEditViewModel(weightSet: weightSet)
    }
}

