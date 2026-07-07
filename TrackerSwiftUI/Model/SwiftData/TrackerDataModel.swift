//
//  Tracker.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 28.06.2026.
//

import SwiftData
import Foundation
import SwiftUI

@Model
class TrackerDataModel {
    
    @Attribute(.unique) var id = UUID()
    var category: TrackerCategory
    
    var title: String
    var emoji: String
    var isHabbit: Bool
    var isPinned: Bool
    var hexColor: String
    
    @Relationship(deleteRule: .nullify) var schedule: [TrackerScheduleModel]
    
    @Transient var color: Color {
        Color(hex: hexColor, alpha: 1)
    }
    
    init(title: String,
         emoji: String,
         isHabbit: Bool,
         isPinned: Bool,
         hexColor: String,
         schedule: [TrackerScheduleModel],
         trackerCategory: TrackerCategory) {
        self.title = title
        self.emoji = emoji
        self.isHabbit = isHabbit
        self.isPinned = isPinned
        self.category = trackerCategory
        self.schedule = schedule
        self.hexColor = hexColor
    }
}
