//
//  WeightSetEditView.swift
//  WeightCalculator
//
//  Created by Вадим on 15.01.2025.
//

import SwiftUI

struct WeightSetEditView: View {
    
    // MARK: - enum
    
    private enum ButtonDirection {
        case up
        case down
    }
    
    // MARK: - Properties
    
    @StateObject var viewModel: WeightSetEditViewModel
    
    @FocusState private var focusedField: UUID?
    
    // MARK: - Body
    
    var body: some View {
        List {
            WeightSetEditSectionView(weights: self.$viewModel.barbells, title: "Barbells",
                                     focusedField: self._focusedField,
                                     newWeightFieldID: self.viewModel.newBarbellFieldID)
            WeightSetEditSectionView(weights: self.$viewModel.plates, title: "Plates",
                                     focusedField: self._focusedField,
                                     newWeightFieldID: self.viewModel.newPlateFieldID)
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                self.navigationKeyboardToolbar()
            }
        }
        .onDisappear {
            self.viewModel.saveChanges()
        }
    }
    
    //  MARK: - View Builders
    
    @ViewBuilder
    private func changeFocusButton(disabled: Bool, direction: ButtonDirection) -> some View {
        let UUIDIndexDictionary = self.viewModel.UUIDIndexDictionary
        Button {
            guard !disabled,
                  let currentFieldUUID = self.focusedField,
                  var index = UUIDIndexDictionary[currentFieldUUID]
            else { return }
            
            index += (direction == .up) ? -1 : 1
            let newFieldUUID = UUIDIndexDictionary.first(where: ({ $0.value == index }))?.key
            self.focusedField = newFieldUUID
        } label: {
            let imageName = "chevron." + String(describing: direction)
            Image(systemName: imageName)
        }
        .disabled(disabled)
    }
    
    @ViewBuilder
    private func navigationKeyboardToolbar() -> some View {
        let isFirst = self.focusedField == self.viewModel.firstUUID
        let isLast = self.focusedField == self.viewModel.lastUUID
        
        self.changeFocusButton(disabled: isFirst, direction: .up)
        self.changeFocusButton(disabled: isLast, direction: .down)
        
        Spacer()
        
        // Done button
        Button {
            self.focusedField = nil
        } label: {
            Text("Done")
                .fontWeight(.semibold)
        }
    }
}

//#Preview {
//    WeightSetEditView(weightSet: .constant(
//        WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8])
//    ))
//}
