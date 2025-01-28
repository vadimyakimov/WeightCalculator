//
//  ContentView.swift
//  WeightCalculator
//
//  Created by Вадим on 11.01.2025.
//

import SwiftUI
import WrappingHStack

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
                
        TabView {
            
            let viewModel = self.viewModel.createWeightSetsListViewModel()
            WeightSetsListView(viewModel: viewModel)
                .tabItem {
                    Label("First", systemImage: "heart.fill")
                }
            
            
            VStack {
                List(self.viewModel.weightSets) { set in
                    Section {
                        ForEach(set.barbells) { weight in
                            HStack {
                                Text("\(weight.value)")
                            }
                        }
                        ForEach(set.plates) { weight in
                            HStack {
                                Text("\(weight.value)")
                            }
                        }
                    } header: {
                        Text("\(set.id)")
                    }

                }
            }
                .tabItem {
                    Label("Second", systemImage: "house.fill")
                }

            Text("Second Tab Content")
                .tabItem {
                    Label("Third", systemImage: "star.fill")
                }
            
        }
    }
}

#Preview {
    ContentView()
}
