//
//  Trackers.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 19.10.2025.
//

import SwiftUI

struct TrackersMain: View {
    
    @ObservedObject private var viewModel = TrackersViewModel()
    @State private var date = Date()
    @State private var isSheetOpen: Bool = false
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationSplitView {
            VStack {
                DisplayedTrackersView()
                    .environmentObject(viewModel)
            }
            .navigationTitle("Trackers")
            .toolbar() {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isSheetOpen.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItem {
                    DatePicker(
                        "", selection: $date,
                        displayedComponents: [.date]
                    )
                    .labelsHidden()
                    .datePickerStyle(.compact)
                }
            }
            
        } detail: {
            Text("Trackers")
        }
        .sheet(isPresented: $isSheetOpen) {
            AddTrackersView()
        }
        .searchable(text: $searchText, prompt: "Search a tracker")
    }
}

#Preview {
    TrackersMain()
}
