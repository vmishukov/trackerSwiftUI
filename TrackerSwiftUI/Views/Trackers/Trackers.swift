//
//  Trackers.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 19.10.2025.
//

import SwiftUI

struct Trackers: View {
    @State private var date = Date()
    
    var body: some View {
        NavigationSplitView {
            VStack {
                Text("Trackers")
            }
            .navigationTitle("Trackers")
            .toolbar() {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
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
    }
}

#Preview {
    Trackers()
}
