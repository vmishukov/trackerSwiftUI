//
//  TrackersViewModel.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 22.06.2026.
//

import SwiftUI
import Combine
import SwiftData

final class TrackersViewModel: ObservableObject {
    
    var modelContext: ModelContext?
    var trackerFetchDescriptor: FetchDescriptor<TrackerDataModel>
    @Published var visibleTrackers: [TrackerDataModel] = []
    @Published var noDisplayedTrackers: Bool = false
    @Published var searchText: String = ""
    @Published var date = Date()
    
    init() {
        trackerFetchDescriptor = {
            let descriptor = FetchDescriptor<TrackerDataModel>()
            return descriptor
        }()
    }
    
    func makeTrackersFilterPredicate() -> Predicate<TrackerDataModel> {
        let searchIsEmpty = searchText.isEmpty
        let calendar = Calendar.current
        let filterDay = Int(calendar.component(.weekday, from: date))
        
        let predicate = #Predicate<TrackerDataModel> { tracker in
            return (tracker.title.contains(searchText) || searchIsEmpty)
            && (tracker.schedule.contains(where: { $0.weekDayNumber == filterDay }))
        }
        return predicate
    }
    
}
