//
//  WeightsList.swift
//  WeightCalculator
//
//  Created by Вадим on 31.01.2025.
//

import SwiftUI
import SwiftUIIntrospect

struct WeightsList: View {
    
    @Binding private var weightSets: [WeightSet]
    
    @State private var editingWeightSetUUID: UUID?
    
    private var onDelete: ((Int) -> Void)?
    private var onEdit: ((Binding<WeightSet>) -> AnyView)?
    //    private var onSelect: ((Int) -> ())?
    
    
    
    var body: some View {
        
        VStack {
            
            
            List(self.weightSets.indices, id: \.self) { index in
                
                let weightSet = self.$weightSets[index]
                
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
                
                .swipeActions {
                    if let onDelete {
                        Button(role: .destructive) {
                            onDelete(index)
//                            withAnimation {
//                                _ = self.weightSets.remove(at: index)
//                            }
                        } label: {
                            Text("Delete")
                        }
                    }
                    if self.onEdit != nil {
                        Button() {
//                            onEdit(weightSet)
                            self.editingWeightSetUUID = weightSet.wrappedValue.id
                        } label: {
                            Text("Edit")
                        }
                    }
                }
            }
            .environment(\.defaultMinListHeaderHeight, 0)
        }
        .background(Color(uiColor: .systemGroupedBackground))
        
    }
    
    init(weightSets: Binding<[WeightSet]>) {
        self._weightSets = weightSets
    }
    
    func onDelete(_ perform: @escaping (Int) -> Void) -> WeightsList {
        var copy = self
        copy.onDelete = perform
        return copy
    }
    
    func onEdit(@ViewBuilder destination: @escaping (Binding<WeightSet>) -> some View) -> WeightsList {
        var copy = self
//        copy.onEdit = perform
        copy.onEdit = { weightSet in
            AnyView(destination(weightSet))
        }
        return copy
    }
    
    //    func onSelect(_ closure: @escaping (Int) -> ()) -> WeightsList {
    //        var copy = self
    //        copy.onSelect = closure
    //        return copy
    //    }
    
    private func editScreenLink(destination: (Binding<WeightSet>) -> some View, weightSet: Binding<WeightSet>) -> some View {
        let isEditScreenShown = Binding {
            self.editingWeightSetUUID == weightSet.wrappedValue.id
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
