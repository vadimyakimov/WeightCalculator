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
    
    // MARK: - Properties
    
    @Published var weightSets: [WeightSet] = []
    @Published var newWeightSet: WeightSet?
    
    private var userSettings: UserSettings
    
    private var token: NotificationToken?
    
    // MARK: - Initializers
    
    init(weightSets: Results<WeightSet>, userSettings: UserSettings) {
        self.weightSets = Array(weightSets)
        self.userSettings = userSettings
        
        self.token = self.createNotificationToken(for: weightSets)
    }
    
    // MARK: - Funcs
    
    func createNotificationToken(for object: Results<WeightSet>) -> NotificationToken {
        let token = object.observe { changes in
            switch changes {
            case .update(let weightSetResults, deletions: let deletions, insertions: let insertions, _: _):
                
                let deletionsIndexSet = IndexSet(deletions)
                withAnimation {
                    self.weightSets.remove(atOffsets: deletionsIndexSet)
                }
                
                for index in insertions {
                    let object = weightSetResults[index]
                    self.weightSets.insert(object, at: index)
                }
                
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
    
    func createWeightSetEditViewModel(for weightSet: Binding<WeightSet>) -> WeightSetEditViewModel {
        return WeightSetEditViewModel(weightSet: weightSet)
    }
}

