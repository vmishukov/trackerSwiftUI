//
//  Tracker.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 17.02.2026.
//

import SwiftUI

struct Tracker: View {
    
    var tracker: TrackerDataModel
    
    var body: some View {
        
        VStack {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 16) {
                        Text(tracker.emoji)
                            .padding(4)
                            .background {
                                Capsule()
                                    .fill(Color.white)
                                    .opacity(0.5)
                            }
                        Text(tracker.title)
                            .font(Font.system(size: 14, weight: .medium))
                            .foregroundStyle(Color(.white))
                    }
                    .padding()
                    Spacer()
                }
            }
            .background(tracker.color)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            VStack {
                HStack {
                    Text("1 день")
                        .font(Font.system(size: 14, weight: .medium))
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(Color(.white))
                            .padding(10)
                            .background {
                                Capsule()
                                    .fill(tracker.color)
                            }
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal)
            }
        }
        .contextMenu {
            Button {
                
            } label: {
                Label("Pin tracker", systemImage: "pin")
            }
            Button {
                
            } label: {
                Label("Edit tracker", systemImage: "square.and.pencil")
            }
            Button(role: .destructive) {
                
            } label: {
                Label("delete tracker", systemImage: "trash")
                
            }
        }
    }
}

#Preview {
    let previewCategory: TrackerCategory = TrackerCategory(title: "test")
    let schedule = TrackerScheduleModel(id: UUID(), weekDayNumber: 1)
    let previewData = TrackerDataModel(title: "ice batch",
                                       emoji: "🥶",
                                       isHabbit: true,
                                       isPinned: false,
                                       hexColor: "065535",
                                       schedule: [schedule],
                                       trackerCategory: previewCategory)
    
    Tracker(tracker: previewData)
        .frame(width: 150)
}
