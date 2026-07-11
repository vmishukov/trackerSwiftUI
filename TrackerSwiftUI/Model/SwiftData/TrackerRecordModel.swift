//
//  TrackerRecordModel.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 08.07.2026.
//

import SwiftData
import Foundation

@Model
class TrackerRecordModel {
    
    var date: Date
    var tracker: TrackerDataModel
    
    init(date: Date, tracker: TrackerDataModel) {
        self.date = date
        self.tracker = tracker
    }
}
