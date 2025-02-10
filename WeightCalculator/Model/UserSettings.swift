//
//  UserSettings.swift
//  WeightCalculator
//
//  Created by Вадим on 06.02.2025.
//

import Foundation

class UserSettings: ObservableObject {
    
    // MARK: - enum
    
    enum UserDefaultsKey: String {
        case selectedWeightSet = "selectedWeightSetUUID"
    }
    
    // MARK: - Properties
    
    @Published var selectedWeightSetUUID: UUID? {
        didSet {
            UserDefaults.standard.set(self.selectedWeightSetUUID?.uuidString, forKey: UserDefaultsKey.selectedWeightSet.rawValue)
        }
    }
    
    @Published var sortOrder: SortOrder = .reverse
    
    // MARK: - Initializer
    
    init() {
        if let selectedWeightSetUuidString = UserDefaults.standard.string(forKey: UserDefaultsKey.selectedWeightSet.rawValue) {
            self.selectedWeightSetUUID = UUID(uuidString: selectedWeightSetUuidString)
        }
    }
    
}
