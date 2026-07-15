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
    
    var isPinnedSort: UInt8
    
    var recordsCount: Int = 0
    @Relationship(deleteRule: .nullify) var schedule: [TrackerScheduleModel]
    @Relationship(deleteRule: .cascade) var records = [TrackerRecordModel]()
    
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
        isPinnedSort = isPinned ? 1 : 0
    }
    
    func addRecord(_ record: TrackerRecordModel) {
        self.records.append(record)
        self.recordsCount = self.records.count
    }
    
    func removeRecord(_ record: TrackerRecordModel) {
        guard let index = self.records.firstIndex(of: record) else { return }
        records.remove(at: index)
        self.recordsCount = self.records.count
    }
}
