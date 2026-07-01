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
    
    @Binding var selectedCategory: TrackerCategory?
    
    @Published var newCategoryIsPresented: Bool = false
    @Published var editCategoryIsPresented: Bool = false
    
    var trackerCategoryToEdit: TrackerCategory?
    
    init(selectedCategory: Binding<TrackerCategory?>) {
        _selectedCategory = selectedCategory
    }
    
    func removeTrackerCategory(modelContext: ModelContext, model: TrackerCategory) {
        modelContext.delete(model)
        selectedCategory = nil
    }
}
