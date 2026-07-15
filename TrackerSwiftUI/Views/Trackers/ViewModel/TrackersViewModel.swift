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
    @Published var searchText: String = ""
    @Published var date = Date()
    @Published var showEditTracker: Bool = false
    @Published var selectedFilter: TrackerFilterType = .allTrackers
    
    var trackerToEdit: TrackerDataModel?
    
    func makeTrackersFilterPredicate() -> Predicate<TrackerDataModel> {
        let searchIsEmpty = searchText.isEmpty
        let calendar = Calendar.current
        let filterDay = Int(calendar.component(.weekday, from: date))
        let startOfDay = calendar.startOfDay(for: date)
        
        switch selectedFilter {
        case .allTrackers:
            return #Predicate<TrackerDataModel> { tracker in
                return (tracker.title.contains(searchText) || searchIsEmpty)
                && (tracker.schedule.contains(where: { $0.weekDayNumber == filterDay }))
                && (tracker.isHabbit || (tracker.records.isEmpty
                                         || tracker.records.contains(where: { $0.date == startOfDay })))
            }
        case .completedTrackers:
            return #Predicate<TrackerDataModel> { tracker in
                return (tracker.title.contains(searchText) || searchIsEmpty)
                && (tracker.schedule.contains(where: { $0.weekDayNumber == filterDay }))
                && (tracker.isHabbit || (tracker.records.isEmpty
                                         || tracker.records.contains(where: { $0.date == startOfDay })))
                && ( tracker.records.contains(where: { $0.date == startOfDay }))
            }
        case .uncopletedTrackers:
            return #Predicate<TrackerDataModel> { tracker in
                return (tracker.title.contains(searchText) || searchIsEmpty)
                && (tracker.schedule.contains(where: { $0.weekDayNumber == filterDay }))
                && (tracker.isHabbit || (tracker.records.isEmpty
                                         || tracker.records.contains(where: { $0.date == startOfDay })))
                && ( !tracker.records.contains(where: { $0.date == startOfDay }))
            }
        }
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
    
    func completeTracker(_ tracker: TrackerDataModel) {
        if let record = tracker.records.first(where: { $0.date.onlyDate == date.onlyDate }) {
            tracker.removeRecord(record)
            modelContext?.delete(record)
        } else {
            let calendar = Calendar.current
            let startOfDay = calendar.startOfDay(for: date)
            let record = TrackerRecordModel(date: startOfDay, tracker: tracker)
            tracker.records.append(record)
            tracker.addRecord(record)
        }
        saveModelContext()
    }
    
    func pinTracker(modelContext: ModelContext, _ tracker: TrackerDataModel) {
        // 1. Меняем значения
        tracker.isPinned.toggle()
        tracker.isPinnedSort = tracker.isPinned ? 1 : 0
        try? modelContext.save()
    }
    
    func checkIfTrackerCompleted(tracker: TrackerDataModel) -> Bool {
        let trackerDays = tracker.records.compactMap(\.date.onlyDate)
        return trackerDays.contains(date.onlyDate)
    }
}

// MARK: - PRIVATE EXTENSION
private extension TrackersViewModel {
    
    func saveModelContext() {
        do {
            try modelContext?.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
