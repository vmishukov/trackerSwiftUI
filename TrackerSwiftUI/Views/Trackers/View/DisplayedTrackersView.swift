//
//  DisplayedTrackersView.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 22.06.2026.
//

import SwiftUI

struct DisplayedTrackersView: View {
    
    @EnvironmentObject var viewModel: TrackersViewModel
    
    var body: some View {
        ScrollView {
            ScrollView {
                TrackerLayout {
                    ForEach(viewModel.visibleTrackers) {
                        Tracker(tracker: $0)
                    }
                }
            }
        }
    }
}

#Preview {
    DisplayedTrackersView()
        .environmentObject(TrackersViewModel())
}
