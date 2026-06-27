//
//  AddCategoryViewModel.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 07.12.2025.
//

import Combine
import SwiftUI
import SwiftData

final class AddCategoryViewModel: ObservableObject {
    
    @Published var newCategoryIsPresented: Bool = false
    @Published var editCategoryIsPresented: Bool = false
    
    var trackerCategoryToEdit: TrackerCategory?
    
    func removeTrackerCategory(modelContext: ModelContext, model: TrackerCategory) {
        modelContext.delete(model)
    }
}
