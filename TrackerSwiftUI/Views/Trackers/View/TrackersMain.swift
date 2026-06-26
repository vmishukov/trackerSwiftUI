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
    @State private var isFiltersOpen: Bool = false
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationSplitView {
            VStack {
                ZStack {
                    DisplayedTrackersView()
                        .environmentObject(viewModel)
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
        .sheet(isPresented: $isFiltersOpen) {
            Builder.makeFiltersView()
                .presentationDetents([.medium])
        }
        .searchable(text: $searchText, prompt: "Search a tracker")
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
