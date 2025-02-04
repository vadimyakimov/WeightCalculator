//
//  View+extension.swift
//  WeightCalculator
//
//  Created by Вадим on 02.02.2025.
//

import SwiftUI

extension View {
    
    func getSize(_ closure: @escaping (CGSize) -> ()) -> some View {
        self
            .background(
                GeometryReader { geo -> Color in
                    Task {
                        closure(geo.size)
                    }
                    return Color.clear
                }
            )
    }
}
