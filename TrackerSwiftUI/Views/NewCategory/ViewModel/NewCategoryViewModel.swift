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
    
    @Published var showErrorAlert: Bool = false
    @Published var categoryName: String = ""
    
    var onDismiss: () -> Void = { }
    
    func checkCategoryNameLenght() {
        guard categoryName.count > 100 else { return }
        categoryName = String(categoryName.prefix(100))
    }
    
    func insertCategory(modelContext: ModelContext) {
        guard checkIfUniqueName(modelContext: modelContext, targetTitle: categoryName)
        else {
            showErrorAlert.toggle()
            return
        }
        let newTrackerCategory = TrackerCategory(title: categoryName)
        modelContext.insert(newTrackerCategory)
        onDismiss()
    }
    
    func editCategory(modelContext: ModelContext, category: TrackerCategory) {
        
        guard checkIfUniqueName(modelContext: modelContext, targetTitle: categoryName)
        else {
            showErrorAlert.toggle()
            return
        }
        category.title = categoryName
        do {
            try modelContext.save()
        } catch {
            print(error.localizedDescription)
        }
        onDismiss()
    }
}

// MARK: - PRIVATE METHODS
private extension NewCategoryViewModel {
    
    func checkIfUniqueName(modelContext: ModelContext, targetTitle: String) -> Bool {
        let targetTitle = targetTitle
        let trackerCategoriesFetchDescriptor = FetchDescriptor<TrackerCategory>(predicate: #Predicate { category in
            category.title == targetTitle
        })
        
        do {
            let foundCategories = try modelContext.fetch(trackerCategoriesFetchDescriptor)
            return foundCategories.isEmpty
        } catch {
            return false
        }
    }
    
}
