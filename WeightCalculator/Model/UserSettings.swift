//
//  UserSettings.swift
//  WeightCalculator
//
//  Created by Вадим on 06.02.2025.
//

import Foundation

enum UserDefaultsKey: String {
    case selectedWeightSet = "selectedWeightSetUUID"
}

class UserSettings: ObservableObject {
    
    @Published var selectedWeightSetUUID: UUID? {
        didSet {
            UserDefaults.standard.set(self.selectedWeightSetUUID?.uuidString, forKey: UserDefaultsKey.selectedWeightSet.rawValue)
        }
    }
    
    init() {
        if let selectedWeightSetUuidString = UserDefaults.standard.string(forKey: UserDefaultsKey.selectedWeightSet.rawValue) {
            self.selectedWeightSetUUID = UUID(uuidString: selectedWeightSetUuidString)
        }
    }
    
}
