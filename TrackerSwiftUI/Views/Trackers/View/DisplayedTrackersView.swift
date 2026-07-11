//
//  DisplayedTrackersView.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 22.06.2026.
//

import SwiftUI
import SwiftData

struct DisplayedTrackersView: View {
    
    @EnvironmentObject var viewModel: TrackersViewModel
    @Query var trackers: [TrackerDataModel]
    @Environment(\.modelContext) var modelContext
    
    init(predicate: Predicate<TrackerDataModel>) {
        let sort = SortDescriptor(\TrackerDataModel.title, order: .forward)
        _trackers = Query(filter: predicate, sort: [sort])
    }
    
    var body: some View {
        ScrollView {
            ScrollView {
                TrackerLayout {
                    ForEach(trackers) { tracker in
                        Tracker(tracker: tracker,
                                onDelete: {
                            viewModel.deleteTracker(modelContext: modelContext, tracker)
                            
                        },
                                onPin: {},
                                onEdit: {
                            viewModel.editTracker(tracker)
                            
                        }, onComplete: {
                            viewModel.completeTracker(modelContext: modelContext,
                                                      tracker)
                        }, isComplete: viewModel.checkIfTrackerCompleted(tracker: tracker))
                    }
                }
            }
        }
    }
}

#Preview {
    let predicate = #Predicate<TrackerDataModel> { tracker in
        return true
    }
    DisplayedTrackersView(predicate: predicate)
        .environmentObject(TrackersViewModel())
}
