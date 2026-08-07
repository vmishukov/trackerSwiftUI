//
//  Builder.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 30.12.2025.
//

import Foundation
import SwiftUI

struct Builder {
    
    static func makeNewTrackerView(isOneTimeAction: Bool = false,
                                   modelToEdit: TrackerDataModel? = nil,
                                   addTrackerClose: Binding<Bool>? = nil
    
    ) -> NewTrackerView {
        let viewModel = NewTrackerViewModel(isOneTimeAction: isOneTimeAction, trackerToEdit: modelToEdit)
        return NewTrackerView(viewModel: viewModel, addTrackerClose: addTrackerClose)
    }
    
    static func makeNewCategoryView(modelToEdit: TrackerCategory? = nil) -> NewCategoryView {
        return NewCategoryView(modelToEdit: modelToEdit)
    }
    
    static func makeFiltersView(selectedFilter: Binding<TrackerFilterType>) -> FiltersView {
        return FiltersView(viewModel: FiltersViewModel(selectedFilter: selectedFilter))
    }
}
