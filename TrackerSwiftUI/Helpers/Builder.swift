//
//  Builder.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 30.12.2025.
//

import Foundation


struct Builder {
    
    static func makeNewTrackerView(isOneTimeAction: Bool = false) -> NewTrackerView {
        let viewModel = NewTrackerViewModel(isOneTimeAction: isOneTimeAction)
        return NewTrackerView(viewModel: viewModel)
    }
    
    static func makeNewCategoryView(modelToEdit: TrackerCategory? = nil) -> NewCategoryView {
        return NewCategoryView(modelToEdit: modelToEdit)
    }
    
    static func makeFiltersView() -> FiltersView {
        return FiltersView()
    }
}
