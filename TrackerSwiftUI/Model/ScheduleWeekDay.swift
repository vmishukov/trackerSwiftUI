//
//  ScheduleWeekDay.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 28.06.2026.
//

import Foundation

enum ScheduleWeekDay: Codable, CaseIterable {
    
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    
    var title: String {
        switch self {
        case .monday: return "Monday"
        case .tuesday: return "Tuesday"
        case .wednesday: return "Wednesday"
        case .thursday: return "Thursday"
        case .friday: return "Friday"
        case .saturday: return "Saturday"
        case .sunday: return "Sunday"
        }
    }
}
