//
//  Binding+extension.swift
//  WeightCalculator
//
//  Created by Вадим on 29.01.2025.
//

import SwiftUI

extension Binding {
    @MainActor
    func unwrap<T>() -> Binding<T>? where Value == T? {
        guard let value = self.wrappedValue else { return nil }
        
        return Binding<T>(
            get: { value },
            set: { self.wrappedValue = $0 }
        )
    }
}
