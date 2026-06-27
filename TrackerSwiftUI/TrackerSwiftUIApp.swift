//
//  TrackerSwiftUIApp.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 12.10.2025.
//

import SwiftUI
import SwiftData

@main
struct TrackerSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: TrackerCategory.self)
    }
}
