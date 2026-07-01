//
//  Category.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 26.06.2026.
//

import SwiftData
import Foundation

@Model
class TrackerCategory {
    
    @Attribute(.unique) var uuid: UUID = UUID()
    @Attribute(.unique) var title: String
    
    @Relationship(deleteRule: .cascade, inverse: \TrackerDataModel.category)
    var trackers = [TrackerDataModel]()
    
    init(title: String) {
        self.title = title
    }
}
