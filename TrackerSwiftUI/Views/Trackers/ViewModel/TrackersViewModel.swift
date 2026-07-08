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
    
    @Published var searchText: String = ""
    @Published var date = Date()
    @Published var showEditTracker: Bool = false
    
    var trackerToEdit: TrackerDataModel?
    
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
    
    func deleteTracker(modelContext: ModelContext, _ tracker: TrackerDataModel) {
        modelContext.delete(tracker)
        do {
            try modelContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func editTracker(_ tracker: TrackerDataModel) {
        trackerToEdit = tracker
        showEditTracker.toggle()
    }
    
}

// MARK: - PRIVATE EXTENSION
private extension NewTrackerViewModel {
    
}
