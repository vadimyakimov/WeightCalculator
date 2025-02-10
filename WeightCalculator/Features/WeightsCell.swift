//
//  WeightsCell.swift
//  WeightCalculator
//
//  Created by Вадим on 28.01.2025.
//

import SwiftUI
//import RealmSwift
import WrappingHStack

struct WeightsCell: View {
    
    // MARK: - Properties
    
    @Binding var weightSet: WeightSet
    @Binding var selectedWeightsIndices: Set<Int>
    
    private var onTap: (([WeightUnit]) -> ())?
    
    // MARK: - body
    
    var body: some View {
        
        let weights = Array(self.weightSet.barbells) + Array(self.weightSet.plates)
        let barbellsCount = self.weightSet.barbells.count
        
        
        WrappingHStack(weights.indices, spacing: .constant(6), lineSpacing: 6) { index in
            let string = self.formatWeightUnit(weights[index])
            Text(string)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(index < barbellsCount ? Color.barbellFill : Color.plateFill)
                .foregroundColor(.white)
                .cornerRadius(8)
                .overlay {
                    if self.selectedWeightsIndices.contains(index) {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1.5)
                            .fill(index < barbellsCount ? Color.barbellStroke : Color.plateStroke)
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(uiColor: .secondarySystemBackground))
                            .opacity(0.5)
                    }
                }
                .gesture(
                    self.onTap != nil ? TapGesture()
                        .onEnded {
                            if !self.selectedWeightsIndices.insert(index).inserted {
                                self.selectedWeightsIndices.remove(index)
                            }
                            let selectedWeightUnits = self.selectedWeightsIndices.compactMap { weights[safe: $0] }
                            self.onTap?(selectedWeightUnits)
                        } :  nil
                )
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
    }
    
    // MARK: - Initializers
    
    init(weightSet: Binding<WeightSet>) {
        self._weightSet = weightSet
        self._selectedWeightsIndices = Binding(get: { [] }, set: { _ in })
    }
    
    init(weightSet: Binding<WeightSet>, selectedWeightsIndices: Binding<Set<Int>>) {
        self._weightSet = weightSet
        self._selectedWeightsIndices = selectedWeightsIndices
    }
    
    // MARK: - Funcs
    
    func onTap(_ closure: (([WeightUnit]) -> ())?) -> WeightsCell {
        var copy = self
        copy.onTap = closure
        return copy
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

