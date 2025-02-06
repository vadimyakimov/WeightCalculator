//
//  WeightsList.swift
//  WeightCalculator
//
//  Created by Вадим on 31.01.2025.
//

import SwiftUI
//import SwiftUIIntrospect
import RealmSwift

struct WeightsList: View {
    
    @Binding private var weightSets: [WeightSet]
    @State private var editingWeightSetUUID: UUID?
    
    @EnvironmentObject var userSettings: UserSettings
    
    private var onDelete: ((WeightSet) -> Void)?
    private var onEdit: ((Binding<WeightSet>) -> AnyView)?
    private var onSelect: ((UUID) -> ())?
    
    
    
    var body: some View {
        
        VStack {
            
            List(self.$weightSets, selection: self.$userSettings.selectedWeightSetUUID) { weightSet in
                
                if !weightSet.wrappedValue.barbells.isEmpty && !weightSet.wrappedValue.plates.isEmpty {
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
                        }
                    }
                    
//                    .onTapGesture {
//                        self.userSettings.selectedWeightSetUUID = weightSet.id
//                    }
                    
                }
                
                
            }
            .environment(\.defaultMinListHeaderHeight, 0)
        }
        .background(Color(uiColor: .systemGroupedBackground))
    }
    
    init(weightSets: Binding<[WeightSet]>) {
        self._weightSets = weightSets
    }
    
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
    
    func onSelect(_ closure: @escaping (UUID) -> ()) -> WeightsList {
        var copy = self
        copy.onSelect = closure
        return copy
    }
    
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

//#Preview {
//    WeightsList()
//}
