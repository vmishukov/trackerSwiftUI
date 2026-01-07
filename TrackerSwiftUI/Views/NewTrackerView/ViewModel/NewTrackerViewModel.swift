//
//  NewTrackerView.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 02.12.2025.
//

import Foundation
import SwiftUI
import Combine

final class NewTrackerViewModel: ObservableObject {
    
    let isOneTimeAction: Bool
    
    let emojis = NewTrackerEmojiModel.makeEmojisModel()
    let colors = NewTrackerColorModel.makeColorModels()
    
    @Published var titleString: String
    
    @Published var addCategoryIsPresented: Bool = false
    @Published var scheduleIsPresented: Bool = false
    
    @Published var trackerName: String = ""
    @Published var canCreateTracker: Bool = true
    
    @Published var selectedEmojiId: UUID?
    @Published var selectedColorId: UUID?
    @Published var isClosing: Bool = false
    
    init(isOneTimeAction: Bool) {
        self.isOneTimeAction = isOneTimeAction
        titleString = isOneTimeAction ? "New one time action" : "New Habbit"
    }
}

// MARK: - PRIVATE METHODS
private extension NewTrackerViewModel {
    
}
