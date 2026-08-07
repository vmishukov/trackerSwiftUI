//
//  NewTrackerColorModel.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 30.11.2025.
//

import SwiftUI

struct NewTrackerColorModel: Identifiable {
    
    let id = UUID()
    let color: Color
}

extension NewTrackerColorModel {
    static func makeColorModels() -> [NewTrackerColorModel] {
        [
            NewTrackerColorModel(color: .red),
            NewTrackerColorModel(color: .blue),
            NewTrackerColorModel(color: .yellow),
            NewTrackerColorModel(color: .green),
            NewTrackerColorModel(color: .purple),
            NewTrackerColorModel(color: .black),
            
            
            NewTrackerColorModel(color: .brown),
            NewTrackerColorModel(color: .gray),
            NewTrackerColorModel(color: .cyan),
            NewTrackerColorModel(color: .indigo),
            NewTrackerColorModel(color: .mint),
            NewTrackerColorModel(color: .pink),
            
            NewTrackerColorModel(color: .init(hex: "#003b5c")),
            NewTrackerColorModel(color: .init(hex: "#41b6e6")),
            NewTrackerColorModel(color: .init(hex: "#c71585")),
            NewTrackerColorModel(color: .init(hex: "#f60018")),
            NewTrackerColorModel(color: .init(hex: "FFD700")),
            NewTrackerColorModel(color: .init(hex: "#4d648d"))
        ]
    }
}
