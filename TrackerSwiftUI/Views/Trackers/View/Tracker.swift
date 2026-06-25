//
//  Tracker.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 17.02.2026.
//

import SwiftUI

struct Tracker: View {
    
    var tracker: TrackerModel
    
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
                        Text(tracker.text)
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
    }
}

#Preview {
    Tracker(tracker: TrackerModel(text: "test", emoji: "🗿", color: .cyan))
        .frame(width: 150)
}
