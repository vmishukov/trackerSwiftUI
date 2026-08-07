//
//  ScheduleModel.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 03.01.2026.
//

import Foundation
import SwiftUI
import Combine

struct ScheduleModel: Identifiable {
    
    let id = UUID()
    var title: String
    var weekDay: ScheduleWeekDay
    var isOn: Bool
    
    init(title: String, weekDay: ScheduleWeekDay, isOn: Bool) {
        self.title = title
        self.weekDay = weekDay
        self.isOn = isOn
    }
}
