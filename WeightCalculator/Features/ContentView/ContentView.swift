//
//  ContentView.swift
//  WeightCalculator
//
//  Created by Вадим on 11.01.2025.
//

import SwiftUI
import WrappingHStack

struct ContentView: View {
    
    enum Tab {
        case finder
        case summator
        case list
    }
    
    var viewModel = ContentViewModel()
    @State var selectedTab: Tab = .summator
    
    
    
    var body: some View {
        
            TabView(selection: self.$selectedTab) {
                
                
                
                let finderViewModel = self.viewModel.createWeightFinderViewModel()
                WeightFinderView(viewModel: finderViewModel)
                    .tag(Tab.finder)
                    .tabItem {
                        Label("Weights Finder", systemImage: "house.fill")
                    }
                
                
                let summatorViewModel = self.viewModel.createWeightSummatorViewModel()
                WeightSummatorView(viewModel: summatorViewModel)
                    .tag(Tab.summator)
                    .tabItem {
                        Label("Third", systemImage: "star.fill")
                    }
                 
                
                let listViewModel = self.viewModel.createWeightSetsListViewModel()
                WeightSetsListView(viewModel: listViewModel)
                    .tag(Tab.list)
                    .tabItem {
                        Label("Weights List", systemImage: "heart.fill")
                    }
                
            }
            .environmentObject(self.viewModel.userSettings)
    }
}

#Preview {
    ContentView()
}
