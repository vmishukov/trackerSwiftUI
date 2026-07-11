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
        let startOfDay = calendar.startOfDay(for: date)
        let predicate = #Predicate<TrackerDataModel> { tracker in
            return (tracker.title.contains(searchText) || searchIsEmpty)
            && (tracker.schedule.contains(where: { $0.weekDayNumber == filterDay }))
            && (tracker.isHabbit || (tracker.records.isEmpty
                                     || tracker.records.contains(where: { $0.date == startOfDay })))
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
    
    func completeTracker(modelContext: ModelContext,
                         _ tracker: TrackerDataModel) {
        if let record = tracker.records.first(where: { $0.date.onlyDate == date.onlyDate }),
           let index = tracker.records.firstIndex(of: record) {
            tracker.records.remove(at: index)
        } else {
            let calendar = Calendar.current
            let startOfDay = calendar.startOfDay(for: date)
            let record = TrackerRecordModel(date: startOfDay, tracker: tracker)
            tracker.records.append(record)
        }
    }
    
    func checkIfTrackerCompleted(tracker: TrackerDataModel) -> Bool {
        let trackerDays = tracker.records.compactMap(\.date.onlyDate)
        return trackerDays.contains(date.onlyDate)
    }
}

// MARK: - PRIVATE EXTENSION
private extension NewTrackerViewModel {
    
}
