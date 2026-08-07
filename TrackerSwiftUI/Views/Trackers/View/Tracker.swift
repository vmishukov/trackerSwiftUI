//
//  Tracker.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 17.02.2026.
//

import SwiftUI
import SwiftData

enum TrackerActionStatus {
    
    case completed
    case removeComplete
    case error
}

struct Tracker: View {
    
    @Bindable var tracker: TrackerDataModel
    var isComplete: Bool
    var onComplete: (TrackerDataModel) -> TrackerActionStatus
    @State private var emitCount = 0
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text(tracker.emoji)
                                .padding(4)
                                .background {
                                    Capsule()
                                        .fill(Color.white)
                                        .opacity(0.5)
                                }
                            Spacer()
                            if tracker.isPinned {
                                Image(systemName: "pin.fill")
                                    .offset(x: 16, y: -10)
                                    .foregroundStyle(Color.white.opacity(0.8))
                            }
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
            .padding(.top, 4)
            .overlay(
                EmojiEmitterView(emojis: [tracker.emoji], emitCount: $emitCount)
                    .edgesIgnoringSafeArea(.all)
                    .allowsHitTesting(false)
            )
        }
    }
    
    func makeOneTimeActionView() -> some View {
        Button {
            switch onComplete(tracker) {
                
            case .completed:
                emitCount += 1
            case .removeComplete:
                break
            case .error:
                break
            }
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
            Text("\(tracker.recordsCount) completed")
                .font(Font.system(size: 14, weight: .medium))
            Spacer()
            Button {
                switch onComplete(tracker) {
                case .completed:
                    emitCount += 1
                    playSuccessVibration()
                case .removeComplete:
                    break
                case .error:
                    playErrorVibration()
                }
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
    
    func playSuccessVibration() {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(.success)
    }
    
    func playErrorVibration() {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(.error)
    }
}

#Preview {
    let previewCategory: TrackerCategory = TrackerCategory(title: "test")
    let schedule = TrackerScheduleModel(weekDayNumber: 1)
    let previewData = TrackerDataModel(title: "ice batch",
                                       emoji: "🥶",
                                       isHabbit: true,
                                       isPinned: false,
                                       hexColor: "065535",
                                       schedule: [schedule],
                                       trackerCategory: previewCategory)
    
    Tracker(tracker: previewData, isComplete: false, onComplete: { _ in return .completed})
        .frame(width: 150, height: 150)
}
