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
                    Label("Weights List", systemImage: "heart.fill")
                }
            
            WeightFinderView()
                .tabItem {
                    Label("Weights Finder", systemImage: "house.fill")
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
