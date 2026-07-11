//
//  Tracker.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 17.02.2026.
//

import SwiftUI

struct Tracker: View {
    
    var tracker: TrackerDataModel
    
    var onDelete: (() -> Void)?
    var onPin: (() -> Void)?
    var onEdit: (() -> Void)?
    var onComplete: () -> Void
    var isComplete: Bool
    
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
                if tracker.isHabbit {
                    makeHabbitBottomView()
                } else {
                    makeOneTimeActionView()
                }
            }
        }
        .contextMenu {
            Button {
                onPin?()
            } label: {
                Label("Pin tracker", systemImage: "pin")
            }
            Button {
                onEdit?()
            } label: {
                Label("Edit tracker", systemImage: "square.and.pencil")
            }
            Button(role: .destructive) {
                onDelete?()
            } label: {
                Label("delete tracker", systemImage: "trash")
                
            }
        }
    }
    
    func makeOneTimeActionView() -> some View {
        Button {
            onComplete()
        } label: {
            Image(systemName: isComplete ? "checkmark" : "plus")
                .foregroundStyle(isComplete ? Color(.white) : tracker.color)
                .padding(10)
                .frame(maxWidth: .greatestFiniteMagnitude)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isComplete ? tracker.color : tracker.color.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(tracker.color,
                                        lineWidth: 4)
                        )
                }
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 6)
        .padding(.bottom, 6)
    }
    
    func makeHabbitBottomView() -> some View {
        HStack {
            Text("\(tracker.records.count) completed")
                .font(Font.system(size: 14, weight: .medium))
            Spacer()
            Button {
                onComplete()
            } label: {
                Image(systemName: isComplete ? "checkmark" : "plus")
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

#Preview {
    let previewCategory: TrackerCategory = TrackerCategory(title: "test")
    let schedule = TrackerScheduleModel(weekDayNumber: 1)
    let previewData = TrackerDataModel(title: "ice batch",
                                       emoji: "🥶",
                                       isHabbit: false,
                                       isPinned: false,
                                       hexColor: "065535",
                                       schedule: [schedule],
                                       trackerCategory: previewCategory)
    
    Tracker(tracker: previewData, onComplete: {}, isComplete: false)
        .frame(width: 150)
}
