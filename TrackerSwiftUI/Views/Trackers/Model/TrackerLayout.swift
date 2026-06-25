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
        let safeProposalWidth = proposal.replacingUnspecifiedDimensions().width
        let cardWidth = (safeProposalWidth - itemSpacing) / CGFloat(numberOfColumns)
        var columnHeights = [CGFloat](repeating: 0.0, count: numberOfColumns)
        
        for subView in subviews {
            let height = subView.sizeThatFits(.init(width: cardWidth, height: nil)).height
            guard let columnIndex = columnHeights.enumerated().min(by: { $0.element < $1.element })?.offset
            else { continue }
            guard columnHeights.count > columnIndex else { continue }
            if columnHeights[columnIndex] > 0 {
                columnHeights[columnIndex] += itemSpacing
            }
            
            columnHeights[columnIndex] += height
        }
        
        return CGSize(
            width: cardWidth * CGFloat(numberOfColumns) + itemSpacing,
            height: columnHeights.max() ?? .zero
        )
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let safeProposalWidth = proposal.replacingUnspecifiedDimensions().width
        let cardWidth = (safeProposalWidth - itemSpacing) / CGFloat(numberOfColumns)
        var yOffset = [CGFloat](repeating: bounds.minY, count: numberOfColumns)
        
        for subView in subviews {
            guard let columnIndex = yOffset.enumerated().min(by: { $0.element < $1.element })?.offset
            else { continue }
            
            let xPos = bounds.minX + (cardWidth + itemSpacing) * CGFloat(columnIndex)
            let height = subView.sizeThatFits(.init(width: cardWidth, height: nil)).height
            guard yOffset.count > columnIndex else { continue }
            let yPos = yOffset[columnIndex]
            
            subView.place(
                at: CGPoint(x: xPos, y: yPos),
                proposal: ProposedViewSize(width: cardWidth, height: height)
            )
            
            yOffset[columnIndex] += height + itemSpacing
        }
    }
}

