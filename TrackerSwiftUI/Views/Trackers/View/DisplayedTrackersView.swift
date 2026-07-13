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
        let pinSort: SortDescriptor<TrackerDataModel> = .init(\.isPinnedSort, order: .reverse)
        _trackers = Query(filter: predicate, sort: [pinSort, sort])
    }
    
    var body: some View {
        ScrollView {
            TrackerLayout {
                ForEach(trackers) { tracker in
                    TrackerCardRow(tracker: tracker, viewModel: viewModel)
                }
            }
        }
        .onAppear {
            viewModel.modelContext = modelContext
        }
    }
}

// MARK: - New Subview (Solves the UI refreshing issue)
struct TrackerCardRow: View {
    
    var tracker: TrackerDataModel
    @ObservedObject var viewModel: TrackersViewModel
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        Tracker(
            tracker: tracker,
            isComplete: viewModel.checkIfTrackerCompleted(tracker: tracker), onComplete: {
                viewModel.completeTracker($0)
            }
        )
        .contentShape(Rectangle())
        .contextMenu {
            Button {
                viewModel.pinTracker(modelContext: modelContext, tracker)
            } label: {
                Label(tracker.isPinned ? "Unpin" : "Pin", systemImage: tracker.isPinned ? "pin.slash" : "pin")
            }
            
            Button {
                viewModel.editTracker(tracker)
            } label: {
                Label("Edit tracker", systemImage: "square.and.pencil")
            }
            
            Button(role: .destructive) {
                viewModel.deleteTracker(modelContext: modelContext, tracker)
            } label: {
                Label("Delete tracker", systemImage: "trash")
            }
        }
        .id("\(tracker.id)-\(tracker.isPinned)")
    }
}

#Preview {
    let predicate = #Predicate<TrackerDataModel> { tracker in
        return true
    }
    DisplayedTrackersView(predicate: predicate)
        .environmentObject(TrackersViewModel())
}
