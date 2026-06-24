//
//  TrackerModel.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 24.06.2026.
//

import SwiftUI

struct TrackerModel: Identifiable {
    
    let id = UUID()
    var text: String
    var emoji: String
    var color: Color
    
}

extension TrackerModel {
    
    static func makeMockTrackerModels() -> [TrackerModel] {
        [
            TrackerModel(text: "First", emoji: "🐶", color: .red),
            TrackerModel(text: "Second", emoji: "🐱", color: .blue),
            TrackerModel(text: "Fou thought this was a normal job interview? We take the cleanliness of our employee's ears very seriously!!", emoji: "🐭", color: .yellow),
            TrackerModel(text: "Fourth", emoji: "❤️", color: .indigo),
            TrackerModel(text: "Fith", emoji: "🤣", color: .red),
            TrackerModel(text: "Sixth", emoji: "😰", color: .brown),
        ]
    }
}
