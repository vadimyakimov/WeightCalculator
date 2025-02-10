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
    
    // MARK: - Properties
    
    @StateObject var viewModel: WeightSetsListViewModel
    
    @State private var editingWeightSet: WeightSet?
    
    // MARK: - body
    
    var body: some View {
        NavigationView {
            VStack {
                WeightsList(weightSets: self.$viewModel.weightSets, isSelectable: true)
                    .onDelete(self.viewModel.remove)
                    .onEdit { weightSet in
                        let viewVodel = self.viewModel.createWeightSetEditViewModel(for: weightSet)
                        WeightSetEditView(viewModel: viewVodel)
                    }
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
}
