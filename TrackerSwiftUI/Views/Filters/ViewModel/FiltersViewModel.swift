//
//  FiltersViewModel.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 26.06.2026.
//

import SwiftUI
import Combine

enum TrackerFilterType {
    
    case allTrackers
    case completedTrackers
    case uncopletedTrackers
    
    
    var title: String {
        
        switch self {
            
        case .allTrackers:
            "All Trackers"
        case .completedTrackers:
            "Completed Trackers"
        case .uncopletedTrackers:
            "Uncopleted Trackers"
        }
    }
}

final class FiltersViewModel: ObservableObject {
    
    @Published var selectedFilter: TrackerFilterType = .allTrackers
    
    func selectFilter(_ filter: TrackerFilterType) {
        
        selectedFilter = filter
    }
}
