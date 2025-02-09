//
//  WeightSummatorView.swift
//  WeightCalculator
//
//  Created by Вадим on 07.02.2025.
//

import SwiftUI

struct WeightSummatorView: View {
    
    @StateObject var viewModel: WeightSummatorViewModel
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                
                Spacer()
                    .frame(maxHeight: proxy.size.height / 2)
                
                let weightSumString = self.formatWeightUnit(self.viewModel.weightSum)
                Text(weightSumString)
                    .font(.title)
                
                if let weightSet = self.$viewModel.weightSet.unwrap() {
                    WeightsCell(weightSet: weightSet, selectedWeightsIndices: self.$viewModel.selectedWeightIndices)
                        .onTap(self.viewModel.onTap)
                } else {
                    Text("You need to select a weight set first.")
                        .padding(.top, 16)
                }
            }
            .frame(maxWidth: .infinity)
        }
        
        
        .padding()
        .frame(maxHeight: .infinity)
        .background(Color(uiColor: .systemGroupedBackground))
    }
    
    private func formatWeightUnit(_ number: Double) -> String {
        let formatter = MeasurementFormatter()
        formatter.locale = Locale.current
        formatter.unitStyle = .short
        formatter.numberFormatter.maximumFractionDigits = 2
        let measurment = Measurement(value: number, unit: UnitMass.kilograms)
        return formatter.string(from: measurment)
    }
}

//#Preview {
//    WeightSummatorView()
//}
