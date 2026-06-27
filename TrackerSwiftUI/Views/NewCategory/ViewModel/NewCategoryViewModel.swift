//
//  NewCategoryViewModel.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 30.12.2025.
//

import Combine
import SwiftUI
import SwiftData

final class NewCategoryViewModel: ObservableObject {
    
    @Published var categoryName: String = ""
    @Environment(\.modelContext) var modelContext
    
    func checkCategoryNameLenght() {
        guard categoryName.count > 100 else { return }
        categoryName = String(categoryName.prefix(100))
    }
    
    func insertCategory(modelContext: ModelContext) {
        let newTrackerCategory = TrackerCategory(title: categoryName)
        modelContext.insert(newTrackerCategory)
    }
    
    func editCategory(modelContext: ModelContext, category: TrackerCategory) {
        category.title = categoryName
        do {
            try modelContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - PRIVATE METHODS
private extension NewCategoryViewModel {
    
  
}
