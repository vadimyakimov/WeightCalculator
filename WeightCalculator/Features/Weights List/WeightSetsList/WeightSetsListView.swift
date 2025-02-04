//
//  WeightSetsListView.swift
//  WeightCalculator
//
//  Created by Вадим on 15.01.2025.
//

import SwiftUI
//import RealmSwift
import UIKit

struct WeightSetsListView: View {
    
    @StateObject var viewModel: WeightSetsListViewModel
//    @State private var isActive = false
    
    @State private var editingWeightSet: WeightSet?
    
    var body: some View {
        NavigationView {
            VStack {
                
                
                WeightsList(weightSets: self.$viewModel.weightSets)
                    .onDelete(self.viewModel.remove)
                    .onEdit { weightSet in
//                        self.editingWeightSet = weightSet.wrappedValue
                        let viewVodel = self.viewModel.createWeightSetEditViewModel(for: weightSet)
                        WeightSetEditView(viewModel: viewVodel)
                    }
                
                    .navigationTitle("Sets")
                
                
            }
        }
        
        
    }
    
//    init(viewModel: WeightSetsListViewModel, editingWeightSet: WeightSet? = nil) {
//        self.viewModel = viewModel
//        self.editingWeightSet = editingWeightSet
//    }
    
}

/*
 #Preview {
 let weightSets: Published<[WeightSet]> = Published(initialValue: [
 WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]),
 WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]),
 WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]),
 WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]),
 ])
 //    let weightSets: Binding<[WeightSet]> = .constant([
 //        WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8])
 //    ])
 let viewModel = WeightSetsListViewModel(weightSets: weightSets)
 WeightSetsListView(viewModel: viewModel)
 }
 */

