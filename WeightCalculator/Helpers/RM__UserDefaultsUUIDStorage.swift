//
//  UserDefaultsUUIDStorage.swift
//  WeightCalculator
//
//  Created by Вадим on 06.02.2025.
//

import SwiftUI

//enum UserDefaultsKey: String {
//    case selectedWeightSet = "selectedWeightSetUUID"
//}

@MainActor
@propertyWrapper
struct UserDefaultsUUIDStorage: DynamicProperty, Sendable {
    
    private let key: String
    private let storage: UserDefaults
    
//    @State private var value: UUID?
    
    @Binding var wrappedValue: UUID?

//    {
//        get {
//            self.value
//        }
//        set {
//            self.value = newValue
//            self.storage.set(newValue?.uuidString, forKey: self.key)
//            print(newValue)
//        }
//    }
    
//    @Published var wrappedValue: UUID? {
//            didSet {
//                // Сохраняем в UserDefaults при изменении
//                storage.set(wrappedValue?.uuidString, forKey: key)
//                print(wrappedValue?.uuidString)
//                self.objectWillChange.send()
//            }
//        }

    init(_ key: UserDefaultsKey, storage: UserDefaults = .standard) {
        self.key = key.rawValue
        self.storage = storage
        
        self._wrappedValue = Binding {
            if let uuidString = storage.string(forKey: key.rawValue) {
                return UUID(uuidString: uuidString)
            } else {
                return nil
            }
        } set: { newValue in
            print(newValue)
            storage.set(newValue?.uuidString, forKey: key.rawValue)
        }
        
//        let uuidString = storage.string(forKey: self.key)
//        let uuid = UUID(uuidString: uuidString)
//        self._value = State(initialValue: uuid)
        
//        if let uuidString = storage.string(forKey: self.key),
//            let uuid = UUID(uuidString: uuidString) {
//                self._value = State(initialValue: uuid)
//            } else {
//                self._value = State(initialValue: nil)
//            }
        }

//    var wrappedValue: UUID? {
//        get {
//            guard let string = storage.string(forKey: self.key) else { return nil }
//            return UUID(uuidString: string)
//        }
//        set {
//            storage.set(newValue?.uuidString, forKey: self.key)
//        }
//    }
}
