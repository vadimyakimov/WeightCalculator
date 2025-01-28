//
//  WeightFinderView.swift
//  WeightCalculator
//
//  Created by Вадим on 28.01.2025.
//

import SwiftUI

struct WeightFinderView: View {
    
    @State var requiredWeight: Double?
//    let viewModel = WeightFinderViewModel()
    
    var body: some View {
        TextField("Enter the required weight", value: self.$requiredWeight, format: .number)
            .keyboardType(.decimalPad)
    }
}

#Preview {
    WeightFinderView()
}
