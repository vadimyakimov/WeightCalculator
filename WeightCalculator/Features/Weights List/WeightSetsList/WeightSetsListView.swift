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
        
    @State private var editingWeightSet: WeightSet?
    
    var body: some View {
        NavigationView {
            VStack {
                
                
                
                WeightsList(weightSets: self.$viewModel.weightSets)
                    .onDelete(self.viewModel.remove)
                    .onEdit { weightSet in
                        let viewVodel = self.viewModel.createWeightSetEditViewModel(for: weightSet)
                        WeightSetEditView(viewModel: viewVodel)
                    }
//                    .onSelect(self.viewModel.didSelectWeightSet)
                
                    .navigationTitle("Sets")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                self.viewModel.addNewWeightSet()
                            } label: {
                                Image(systemName: "plus")
                            }
                        }
                    }
                
                if let newWeightSet = self.$viewModel.newWeightSet.unwrap() {
                    let isAddingScreenShown = Binding {
                        self.viewModel.newWeightSet != nil
                    } set: {
                        if !$0 {
                            self.viewModel.newWeightSet = nil
                        }
                    }
                    let viewModel = self.viewModel.createWeightSetEditViewModel(for: newWeightSet)
                    
                    NavigationLink(destination: WeightSetEditView(viewModel: viewModel), isActive: isAddingScreenShown) {
                        EmptyView()
                    }
                    .hidden()
                }
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

