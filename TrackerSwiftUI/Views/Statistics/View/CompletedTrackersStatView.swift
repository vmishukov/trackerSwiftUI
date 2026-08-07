//
//  CompletedTrackersStatView.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 15.07.2026.
//

import SwiftUI
import SwiftData

struct CompletedTrackersStatView: View {
    @Query var completedTrackers: [TrackerRecordModel]
    
    private let rainbow = Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple])
    
    @State private var angle: Double = 0
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(completedTrackers.count)")
                    .font(.system(size: 30, weight: .bold))
                    .padding(.bottom, 1)
                Text("Completed trackers")
                    .font(.system(size: 25, weight: .medium))
            }
            .padding()
            Spacer()
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
    CompletedTrackersStatView()
        .padding(.horizontal)
        .modelContainer(for: TrackerRecordModel.self, inMemory: true)
}

