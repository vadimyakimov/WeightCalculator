//
//  WeightSetsListView.swift
//  WeightCalculator
//
//  Created by Вадим on 15.01.2025.
//

import SwiftUI
import WrappingHStack

struct WeightSetsListView: View {
    
    @StateObject var viewModel: WeightSetsListViewModel
    
    var body: some View {
        NavigationView {
            List(self.$viewModel.weightSets) { weightSet in
                Section {
                    NavigationLink {
                        let viewModel = self.viewModel.createWeightSetEditViewModel(for: weightSet)
                        WeightSetEditView(viewModel: viewModel)
                    } label: {
                        WeightsHStack(weightSet: weightSet)
                    }
                }
            }
        }
    }
    
}

#Preview {
    let weightSets: Published<[WeightSet]> = Published(initialValue: [
        WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8])
    ])
//    let weightSets: Binding<[WeightSet]> = .constant([
//        WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8])
//    ])
    let viewModel = WeightSetsListViewModel(weightSets: weightSets)
    WeightSetsListView(viewModel: viewModel)
}
