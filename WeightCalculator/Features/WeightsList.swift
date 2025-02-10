//
//  WeightsList.swift
//  WeightCalculator
//
//  Created by Вадим on 31.01.2025.
//

import SwiftUI

struct WeightsList: View {
    
    // MARK: - Properties
    
    @Binding private var weightSets: [WeightSet]
    @State private var editingWeightSetUUID: UUID?
    
    @EnvironmentObject private var userSettings: UserSettings
    let isSelectable: Bool
    
    private var onDelete: ((WeightSet) -> Void)?
    private var onEdit: ((Binding<WeightSet>) -> AnyView)?
    
    // MARK: - body
    
    var body: some View {
        VStack {
            List(
                self.$weightSets,
                selection: self.isSelectable ? self.$userSettings.selectedWeightSetUUID : nil
            ) { weightSet in
                
                if !weightSet.wrappedValue.barbells.isEmpty || !weightSet.wrappedValue.plates.isEmpty {
                    Section {
                        HStack {
                            WeightsCell(weightSet: weightSet)
                            if let onEdit {
                                self.editScreenLink(destination: onEdit, weightSet: weightSet)
                            }
                        }
                    } header: {
                        Rectangle().frame(height: 0)
                    } footer: {
                        Rectangle().frame(height: 0)
                    }
                    .listRowInsets(EdgeInsets())
                    .padding(.vertical, 4)
                    .contentShape(Rectangle())
                    
                    .swipeActions {
                        
                        if let onDelete {
                            Button(role: .destructive) {
                                onDelete(weightSet.wrappedValue)
                            } label: {
                                Text("Delete")
                            }
                        }
                        if self.onEdit != nil {
                            Button() {
                                self.editingWeightSetUUID = weightSet.wrappedValue.id
                            } label: {
                                Text("Edit")
                            }
                            .tint(.orange)
                        }
                    }
                }
            }
            .environment(\.defaultMinListHeaderHeight, 0)
        }
        .background(Color(uiColor: .systemGroupedBackground))
    }
    
    // MARK: - Initializer
    
    init(weightSets: Binding<[WeightSet]>, isSelectable: Bool = false) {
        self._weightSets = weightSets
        self.isSelectable = isSelectable
    }
    
    // MARK: - Action functions
    
    func onDelete(_ perform: @escaping (WeightSet) -> Void) -> WeightsList {
        var copy = self
        copy.onDelete = perform
        return copy
    }
    
    func onEdit(@ViewBuilder destination: @escaping (Binding<WeightSet>) -> some View) -> WeightsList {
        var copy = self
        copy.onEdit = { weightSet in
            AnyView(destination(weightSet))
        }
        return copy
    }
    
    // MARK: - Flow funcs
    
    private func editScreenLink(destination: (Binding<WeightSet>) -> some View, weightSet: Binding<WeightSet>) -> some View {
        let isEditScreenShown = Binding {
            guard !weightSet.wrappedValue.isInvalidated else { return false }
            return self.editingWeightSetUUID == weightSet.id
        } set: { isShown in
            if !isShown {
                self.editingWeightSetUUID = nil
            }
        }
        
        return NavigationLink(destination: destination(weightSet), isActive: isEditScreenShown) {
            EmptyView()
        }
        .frame(width: .zero)
        .hidden()
    }
}
