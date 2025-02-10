//
//  SettingsView.swift
//  WeightCalculator
//
//  Created by Вадим on 10.02.2025.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - Properties
    
    @State var sortOrderSelection: SortOrder = .reverse
    var sortOrderOptions: [SortOrder] = [.forward, .reverse]
    
    @FocusState var focused
    
    // MARK: - Body
    
    var body: some View {
        List {            
            Picker("Sorting", selection: self.$sortOrderSelection) {
                ForEach(self.sortOrderOptions, id: \.self) { option in
                    switch option {
                    case .forward:
                        Text("Ascending")
                    case .reverse:
                        Text("Descending")
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
