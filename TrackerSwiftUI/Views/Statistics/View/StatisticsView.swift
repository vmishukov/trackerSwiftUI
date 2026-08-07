//
//  StatisticsView.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 14.07.2026.
//

import SwiftUI
import SwiftData

struct StatisticsView: View {
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack {
                    CompletedTrackersStatView()
                        .padding(.horizontal)
                    if let tracker = getMostExpensiveItem(context: modelContext) {
                        MostTrackedStatView(tracker: tracker)
                            .padding(.horizontal)
                    }
                }
                Spacer()
            }
            .navigationTitle(Text("Statistics"))
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
    
    func getMostExpensiveItem(context: ModelContext) -> TrackerDataModel? {
        let sort = SortDescriptor(\TrackerDataModel.recordsCount, order: .reverse)
        var descriptor = FetchDescriptor<TrackerDataModel>(predicate: nil, sortBy: [sort])
        descriptor.fetchLimit = 1
        
        return try? context.fetch(descriptor).first
    }
    
}

#Preview {
    StatisticsView()
}
