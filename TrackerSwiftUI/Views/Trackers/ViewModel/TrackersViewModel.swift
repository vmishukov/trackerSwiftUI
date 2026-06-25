//
//  TrackersViewModel.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 22.06.2026.
//

import SwiftUI
import Combine

final class TrackersViewModel: ObservableObject {
    
    @Published var visibleTrackers: [TrackerModel] = TrackerModel.makeMockTrackerModels()
    @Published var noDisplayedTrackers: Bool = false
}
