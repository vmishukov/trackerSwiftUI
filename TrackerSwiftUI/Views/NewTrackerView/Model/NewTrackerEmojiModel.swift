//
//  NewTrackerEmojiModel.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 30.11.2025.
//

import Foundation

struct NewTrackerEmojiModel: Identifiable {
    
    let id = UUID()
    let emoji: String
}

extension NewTrackerEmojiModel {
    
    static func makeEmojisModel() -> [NewTrackerEmojiModel] {
        [
            .init(emoji: "👌"),
            .init(emoji: "🌧️"),
            .init(emoji: "🥵"),
            .init(emoji: "😶‍🌫️"),
            .init(emoji: "🤪"),
            .init(emoji: "🤑"),
            
            .init(emoji: "🧠"),
            .init(emoji: "✍️"),
            .init(emoji: "👣"),
            .init(emoji: "🫃"),
            .init(emoji: "🍀"),
            .init(emoji: "🗿"),
            
            .init(emoji: "🏎️"),
            .init(emoji: "⚽️"),
            .init(emoji: "🍆"),
            .init(emoji: "💅"),
            .init(emoji: "🌺"),
            .init(emoji: "🐷"),
        ]
    }
}
