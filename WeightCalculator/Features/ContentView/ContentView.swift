//
//  ContentView.swift
//  WeightCalculator
//
//  Created by Вадим on 11.01.2025.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - enum
    
    enum Tab {
        case finder
        case summator
        case list
        case settings
    }
    
    // MARK: - Properties
    
    var viewModel = ContentViewModel()
    @State var selectedTab: Tab = .list
    
    // MARK: - body
    
    var body: some View {
        
        TabView(selection: self.$selectedTab) {
            let finderViewModel = self.viewModel.createWeightFinderViewModel()
            WeightFinderView(viewModel: finderViewModel)
                .tag(Tab.finder)
                .tabItem {
                    Label("Weights Finder", systemImage: "magnifyingglass")
                }
            
            let summatorViewModel = self.viewModel.createWeightSummatorViewModel()
            WeightSummatorView(viewModel: summatorViewModel)
                .tag(Tab.summator)
                .tabItem {
                    Label("Weights Summator", systemImage: "plus")
                }
            
            let listViewModel = self.viewModel.createWeightSetsListViewModel()
            WeightSetsListView(viewModel: listViewModel)
                .tag(Tab.list)
                .tabItem {
                    Label("Weights List", systemImage: "list.bullet")
                }
        }
        .environmentObject(self.viewModel.userSettings)
    }
}

#Preview {
    ContentView()
}
