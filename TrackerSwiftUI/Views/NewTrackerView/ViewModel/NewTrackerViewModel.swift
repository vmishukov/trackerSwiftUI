//
//  NewTrackerView.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 02.12.2025.
//

import SwiftUI
import SwiftData
import Combine

final class NewTrackerViewModel: ObservableObject {
    
    let isOneTimeAction: Bool
    let emojis = NewTrackerEmojiModel.makeEmojisModel()
    let colors = NewTrackerColorModel.makeColorModels()
    
    @Published var titleString: String
    
    @Published var addCategoryIsPresented: Bool = false
    @Published var scheduleIsPresented: Bool = false
    
    @Published var trackerName: String = "" {
        didSet {
            checkCanCreateTracker()
        }
    }
    
    @Published var canCreateTracker: Bool = false
    
    @Published var selectedEmojiId: UUID? {
        didSet {
            checkCanCreateTracker()
        }
    }
    
    @Published var selectedColorId: UUID? {
        didSet {
            checkCanCreateTracker()
        }
    }
    
    @Published var isClosing: Bool = false
    
    @Published var selectedTrackerCategory: TrackerCategory? {
        didSet {
            checkCanCreateTracker()
        }
    }
    
    @Published var selectedSchedule: [ScheduleWeekDay]? {
        didSet {
            checkCanCreateTracker()
        }
    }
    
    init(isOneTimeAction: Bool) {
        self.isOneTimeAction = isOneTimeAction
        titleString = isOneTimeAction ? "New one time action" : "New Habbit"
    }
    
    func createTracker(with modelContext: ModelContext) {
        guard
            let selectedEmoji = emojis.first(where: { $0.id == selectedEmojiId }),
            let selectedColor = colors.first(where: { $0.id == selectedColorId }),
            let selectedTrackerCategory,
            let selectedSchedule
        else { return }
        
        let dataModel = TrackerDataModel(title: trackerName,
                                         emoji: selectedEmoji.emoji,
                                         isHabbit: !isOneTimeAction,
                                         isPinned: false,
                                         hexColor: selectedColor.color.toHex() ?? "000000",
                                         schedule: getScheduleModels(modelContext: modelContext, schedule: selectedSchedule),
                                         trackerCategory: selectedTrackerCategory)
        modelContext.insert(dataModel)
        do {
            try modelContext.save()
            isClosing.toggle()
        } catch {
            print ("Error saving: \(error)")
        }
    }
    
}

// MARK: - PRIVATE METHODS
private extension NewTrackerViewModel {
    
    func checkCanCreateTracker() {
        canCreateTracker = !trackerName.isEmpty &&
        selectedEmojiId != nil &&
        selectedColorId != nil &&
        selectedTrackerCategory != nil &&
        selectedSchedule?.count != 0
    }
    
    func getScheduleModels(modelContext: ModelContext, schedule: [ScheduleWeekDay]) -> [TrackerScheduleModel] {
        
        var scheduleModels: [TrackerScheduleModel] = []
        do {
            try schedule.forEach {
                let model = try getOrCreateScheduleModel(modelContext: modelContext,
                                                         scheduleDay: $0.rawValue)
                scheduleModels.append(model)
            }
        } catch {
            print(error.localizedDescription)
        }
        return scheduleModels
    }
    
    func getOrCreateScheduleModel(modelContext: ModelContext, scheduleDay: Int) throws -> TrackerScheduleModel {
        let fetchDescriptor = FetchDescriptor<TrackerScheduleModel>( predicate: #Predicate {
            return $0.weekDayNumber == scheduleDay
        })
        let existingModel = try modelContext.fetch(fetchDescriptor)
        
        if let existingModel = existingModel.first {
            return existingModel
        } else {
            let newModel = TrackerScheduleModel(id: UUID(), weekDayNumber: scheduleDay)
            return newModel
        }
    }
}
