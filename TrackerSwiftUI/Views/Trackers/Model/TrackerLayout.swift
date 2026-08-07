//
//  TrackerLayout.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 24.06.2026.
//

import SwiftUI

struct TrackerLayout: Layout {
    private let numberOfColumns: Int
    private let itemSpacing: CGFloat
    
    init(numberOfColumns: Int = 2, itemSpacing: CGFloat = 12) {
        self.numberOfColumns = numberOfColumns
        self.itemSpacing = itemSpacing
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        guard !subviews.isEmpty else { return .zero }
        
        let boundsWidth = proposal.replacingUnspecifiedDimensions().width
        let totalSpacing = CGFloat(numberOfColumns - 1) * itemSpacing
        let cardWidth = (boundsWidth - totalSpacing) / CGFloat(numberOfColumns)
        
        var columnHeights = [CGFloat](repeating: 0.0, count: numberOfColumns)
        
        // Используем enumerated(), чтобы знать порядковый номер элемента
        for (index, subView) in subviews.enumerated() {
            let height = subView.sizeThatFits(.init(width: cardWidth, height: nil)).height
            
            // Строго распределяем: 0-й в 1-ю колонку, 1-й во 2-ю, 2-й в 1-ю и т.д.
            let columnIndex = index % numberOfColumns
            
            if columnHeights[columnIndex] > 0 {
                columnHeights[columnIndex] += itemSpacing
            }
            columnHeights[columnIndex] += height
        }
        
        return CGSize(
            width: boundsWidth,
            height: columnHeights.max() ?? .zero
        )
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        guard !subviews.isEmpty else { return }
        
        let totalSpacing = CGFloat(numberOfColumns - 1) * itemSpacing
        let cardWidth = (bounds.width - totalSpacing) / CGFloat(numberOfColumns)
        
        var yOffset = [CGFloat](repeating: bounds.minY, count: numberOfColumns)
        
        // Здесь логика выбора колонки должна строго совпадать со sizeThatFits
        for (index, subView) in subviews.enumerated() {
            let columnIndex = index % numberOfColumns
            
            let xPos = bounds.minX + CGFloat(columnIndex) * (cardWidth + itemSpacing)
            let yPos = yOffset[columnIndex]
            
            let height = subView.sizeThatFits(.init(width: cardWidth, height: nil)).height
            
            subView.place(
                at: CGPoint(x: xPos, y: yPos),
                proposal: ProposedViewSize(width: cardWidth, height: height)
            )
            
            yOffset[columnIndex] += height + itemSpacing
        }
    }
}
