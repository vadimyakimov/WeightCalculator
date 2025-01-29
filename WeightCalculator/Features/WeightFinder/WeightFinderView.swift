//
//  WeightFinderView.swift
//  WeightCalculator
//
//  Created by Вадим on 28.01.2025.
//

import SwiftUI

struct WeightFinderView: View {
    
    @StateObject var viewModel: WeightFinderViewModel
    
    @State var requiredWeight: Double? 
    
    @State private var scrollViewContentSize: CGSize = .zero
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                if let weightVariants = self.$viewModel.weightVariants.unwrap() {
                    if !weightVariants.isEmpty {
                        ScrollView {
                            Spacer(minLength: 16)
                            ForEach(weightVariants) { weightSet in
                                WeightsHStack(weightSet: weightSet)
                                    .padding(.vertical, 4)
                                    .padding(.horizontal)
                                    .background(Color(uiColor: .secondarySystemGroupedBackground))
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 12)
                                    )
                                    .padding(.horizontal)
                                    .padding(.vertical, 6)
                                //Divider()
                            }
                            Spacer(minLength: 16)
                        }
                        .padding(.bottom, -8)
                        .navigationTitle("Weight Finder")
                        .navigationBarTitleDisplayMode(.large)
                    } else {
                        VStack {
                            Spacer()
                            Text("Suitable weight set is not found.")
                            Spacer()
                        }
                        .navigationTitle("Weight Finder")
                        .navigationBarTitleDisplayMode(.large)
                    }
                } else {
                    Spacer()
                        .navigationTitle("Weight Finder")
                        .navigationBarTitleDisplayMode(.large)
                }
                
                Divider()
                HStack {
                    TextField("Enter the required weight", value: self.$requiredWeight, format: .number)
                        .keyboardType(.decimalPad)
                        .frame(height: 40)
                        .padding(.horizontal, 16)
                        .background(Color(uiColor: .secondarySystemGroupedBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(uiColor: .systemGray), lineWidth: 1)
                        )
                    
                    Button("Find") {
                        self.viewModel.findRequiredWeightSet(for: self.requiredWeight)
                    }
                    .frame(height: 40)
                    .padding(.horizontal, 16)
                    .background(Color.accentColor)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                }
                .padding()
                
            }
            .background(Color(uiColor: .systemGroupedBackground))
        }
    }
}

#Preview {
    let VM = WeightFinderViewModel(weightSet: WeightSet(barbells: [1.1], plates: [4.6, 2.3, 0.9, 1.6, 4.5, 2.3, 0.8]))
    WeightFinderView(viewModel: VM)
}
