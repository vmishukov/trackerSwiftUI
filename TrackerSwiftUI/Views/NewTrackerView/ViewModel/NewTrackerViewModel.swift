//
//  NewTrackerView.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 02.12.2025.
//

import SwiftUI
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
    
    func createTracker() {
        
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
    
}
