//
//  Collection+extension.swift
//  WeightCalculator
//
//  Created by Вадим on 04.02.2025.
//

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
