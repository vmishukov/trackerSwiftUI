//
//  ContentView.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 12.10.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab: Tabs = .statistic
    
    enum Tabs {
        case tracker
        case statistic
    }
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            Trackers()
                .tabItem {
                    Label("Tracker", systemImage: "long.text.page.and.pencil.fill")
                }
                .tag(Tabs.tracker)
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, nibba!")
            }
            .padding()
            .tabItem {
                Label("Statistic", systemImage: "chart.bar.xaxis" )
            }
            .tag(Tabs.tracker)
        }
    }
}

#Preview {
    ContentView()
}
