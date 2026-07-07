//
//  TrackerScheduleModel.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 05.07.2026.
//

import Foundation
import SwiftData

@Model
class TrackerScheduleModel {
    
    @Attribute(.unique) var weekDayNumber: Int
    @Relationship(deleteRule: .nullify, inverse: \TrackerDataModel.schedule)
    var trackers = [TrackerDataModel]()
    
    init(weekDayNumber: Int) {
        self.weekDayNumber = weekDayNumber
    }
}
