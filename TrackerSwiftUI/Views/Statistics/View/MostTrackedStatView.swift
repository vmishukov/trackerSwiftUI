//
//  MostTrackedStatView.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 15.07.2026.
//

import SwiftUI
import SwiftData

struct MostTrackedStatView: View {
    
    var tracker: TrackerDataModel
    
    private let rainbow = Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple])
    
    @State private var angle: Double = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("Most completed tracker")
                    .font(Font.system(size: 25, weight: .medium))
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
            
            GeometryReader { proxy in
                Tracker(tracker: tracker,
                        isComplete: false,
                        onComplete: {_ in .removeComplete })
                .frame(width: proxy.size.width / 2)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .aspectRatio(2, contentMode: .fit)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    AngularGradient(
                        gradient: rainbow,
                        center: .center,
                        angle: Angle(degrees: angle)
                    ),
                    lineWidth: 3
                )
        )
        .onAppear {
            withAnimation(
                .linear(duration: 6)
                .repeatForever(autoreverses: false)
            ) {
                angle = 360
            }
        }
    }
}

#Preview {
    let previewCategory: TrackerCategory = TrackerCategory(title: "test")
    let schedule = TrackerScheduleModel(weekDayNumber: 1)
    let previewData = TrackerDataModel(title: "ice bath",
                                       emoji: "🥶",
                                       isHabbit: true,
                                       isPinned: false,
                                       hexColor: "065535",
                                       schedule: [schedule],
                                       trackerCategory: previewCategory)
    
    MostTrackedStatView(tracker: previewData)
}
