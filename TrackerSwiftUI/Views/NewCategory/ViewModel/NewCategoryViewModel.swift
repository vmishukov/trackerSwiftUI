//
//  NewCategoryViewModel.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 30.12.2025.
//

import Combine
import SwiftUI

final class NewCategoryViewModel: ObservableObject {
    
    @Published var categoryName: String = ""
    
    
    func checkCategoryNameLenght() {
        guard categoryName.count > 100 else { return }
        categoryName = String(categoryName.prefix(100))
    }
}

// MARK: - PRIVATE METHODS
private extension NewCategoryViewModel {
    
  
}
