//
//  WeightsHStack.swift
//  WeightCalculator
//
//  Created by Вадим on 28.01.2025.
//

import SwiftUI
import WrappingHStack

struct WeightsHStack: View {
    
    @Binding var weightSet: WeightSet
    
    var body: some View {
        let weights = self.weightSet.barbells + self.weightSet.plates
        let barbellsCount = self.weightSet.barbells.count
        
        WrappingHStack(weights.indices, spacing: .constant(6), lineSpacing: 6) { index in
            let string = self.formatWeightUnit(weights[index])
            Text(string)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(index < barbellsCount ? Color.blue : Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .padding(.horizontal, 4)
        .padding(.vertical, 8)
    }
    
    private func formatWeightUnit(_ unit: WeightUnit) -> String {
        let formatter = MeasurementFormatter()
        formatter.locale = Locale.current
        formatter.unitStyle = .short
        formatter.numberFormatter.maximumFractionDigits = 2
        let measurment = Measurement(value: unit.value, unit: UnitMass.kilograms)
        return formatter.string(from: measurment)
    }
}

#Preview {
    let set = WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8])
    WeightsHStack(weightSet: .constant(set))
}
