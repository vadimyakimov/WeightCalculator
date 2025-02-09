//
//  WeightFinderView.swift
//  WeightCalculator
//
//  Created by Вадим on 28.01.2025.
//

import SwiftUI

struct WeightFinderView: View {
    
    @StateObject var viewModel: WeightFinderViewModel
        
    @State private var scrollViewContentSize: CGSize = .zero
    @FocusState var isFocused: Bool
    
    var body: some View {        
        NavigationView {
            VStack(spacing: 0) {
                Group {
                    if !self.viewModel.isWeightSetSelected {
                        Text("You need to select a weight set first.")
                    } else if self.viewModel.weightVariants?.isEmpty == true {
                        Text("Suitable weight set is not found.")
                    } else if let weightVariants = self.$viewModel.weightVariants.unwrap() {
                        WeightsList(weightSets: weightVariants)
                    } else {
                        Text("Enter the required weight.")
                    }
                }
                .frame(maxHeight: .infinity)
                
                Divider()
                HStack {
                    TextField("Enter the required weight", value: self.$viewModel.requiredWeight, format: .number)
                        .keyboardType(.decimalPad)
                        .focused(self.$isFocused)
                        .frame(height: 40)
                        .padding(.horizontal, 16)
                        .background(Color(uiColor: .secondarySystemGroupedBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(uiColor: .systemGray), lineWidth: 1)
                                HStack {
                                    if self.viewModel.requiredWeight != nil {
                                        Spacer()
                                        Button(action: {
                                            self.viewModel.requiredWeight = nil
                                        }) {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.trailing, 8)
                                    }
                                }
                            }
                        )
                    
                    
                    Button("Find") {
                        self.isFocused = false
                        Task {
                            withAnimation {
                                self.viewModel.findRequiredWeightSet()                                
                            }
                        }
                    }
                    .frame(height: 40)
                    .padding(.horizontal, 16)
                    .background(Color.accentColor)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                }
                .padding()
                .disabled(self.viewModel.isWeightSetSelected ? false : true)
                
            }
            .navigationTitle("Weight Finder")
            .navigationBarTitleDisplayMode(.large)
            .background(Color(uiColor: .systemGroupedBackground))
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button {
                        self.isFocused = false
                    } label: {
                        Text("Done")
                            .fontWeight(.semibold)
                    }
                }
            }
        }
    }
}

//#Preview {
//    let VM = WeightFinderViewModel(weightSet: WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]))
//    WeightFinderView(viewModel: VM)
//}
