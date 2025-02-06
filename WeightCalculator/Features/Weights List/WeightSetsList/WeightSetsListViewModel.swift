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
    @Published var newWeightSet: WeightSet?
    
    
    
    var token: NotificationToken?
    
    init(weightSets: Results<WeightSet>) {
        self.weightSets = Array(weightSets)
        self.token = self.createNotificationToken(for: weightSets)
    }
    
    func createNotificationToken(for object: Results<WeightSet>) -> NotificationToken {
        let token = object.observe { changes in
            switch changes {
            case .update(let weightSetResults, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                
                let deletionsIndexSet = IndexSet(deletions)
                withAnimation {
                    self.weightSets.remove(atOffsets: deletionsIndexSet)                    
                }
                
                for index in insertions {
                    let object = weightSetResults[index]
                    self.weightSets.insert(object, at: index)
                }
                
                //                for index in modifications {
                //                    if self.weightSets[index].isEmpty {
                //                        self.remove(index)
                //                    }
                //                }
                
                //                self.objectWillChange.send()
            default: break
            }
        }
        
        return token
    }
    
    
    func addNewWeightSet() {
        guard let realm = try? Realm() else { return }
        
        self.newWeightSet = try? realm.write {
            let weightSet = WeightSet()
            realm.add(weightSet)
            return weightSet
        }
    }
    
    func remove(_ object: WeightSet) {
        guard let realm = object.realm else { return }
        
        try? realm.write {
            realm.delete(object.barbells)
            realm.delete(object.plates)
            realm.delete(object)
        }
    }
    
//    func didSelectWeightSet(withId id: UUID) {
//        self.selectedWeightSetUUID = id
//    }
    
    //    func remove(_ index: Int) {
    //        guard let object = self.weightSets[safe: index],
    //              !object.isInvalidated,
    //            let realm = object.realm else { return }
    //
    //        Task {
    //            do {
    //                try await realm.asyncWrite {
    //                    realm.delete(object.barbells)
    //                    realm.delete(object.plates)
    //                    realm.delete(object)
    //                }
    //            } catch {
    //                fatalError()
    //            }
    //        }
    //    }
    
    func createWeightSetEditViewModel(for weightSet: Binding<WeightSet>) -> WeightSetEditViewModel {
        return WeightSetEditViewModel(weightSet: weightSet)
    }
}

