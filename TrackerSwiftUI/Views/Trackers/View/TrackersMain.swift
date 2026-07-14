//
//  Trackers.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 19.10.2025.
//

import SwiftUI

struct TrackersMain: View {
    
    @ObservedObject private var viewModel = TrackersViewModel()
    
    @State private var isSheetOpen: Bool = false
    @State private var isFiltersOpen: Bool = false
    
    
    var body: some View {
        NavigationSplitView {
            VStack {
                ZStack {
                    DisplayedTrackersView(predicate: viewModel.makeTrackersFilterPredicate())
                        .environmentObject(viewModel)
                        .padding(.horizontal)
                    VStack {
                        Spacer()
                        filterButton
                            .padding(.bottom, 8)
                    }
                }
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
                        "", selection: $viewModel.date,
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
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $isFiltersOpen) {
            Builder.makeFiltersView(selectedFilter: $viewModel.selectedFilter)
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $viewModel.showEditTracker) {
            Builder.makeNewTrackerView(isOneTimeAction: !(viewModel.trackerToEdit?.isHabbit ?? true),
                                       modelToEdit: viewModel.trackerToEdit)
        }
        .searchable(text: $viewModel.searchText, prompt: "Search a tracker")
    }
    
    var filterButton: some View {
        Button {
            isFiltersOpen.toggle()
        } label: {
            Text("Filter")
                .font(Font.system(size: 20, weight: .regular))
                .foregroundStyle(.white)
                .padding(.horizontal)
                .padding(.vertical, 10)
                .glassEffect(.regular.tint(.blue).interactive())
        }
        .buttonStyle(.plain)
        
    }
}

#Preview {
    TrackersMain()
}
