//
//  Extension.swift
//  TrackerSwiftUI
//
//  Created by Vladislav Mishukov on 30.11.2025.
//

import Foundation
import SwiftUI

extension Color {
    
    /// Initialize Color from hex string with optional alpha
    /// - Parameters:
    ///   - hex: Hex string (e.g., "#FF0000", "FF0000", "#FF0000FF")
    ///   - alpha: Alpha value (0.0 - 1.0). If nil, alpha will be extracted from hex if available
    init(hex: String, alpha: CGFloat? = nil) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        // Remove # if present
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        
        let red, green, blue, alphaValue: CGFloat
        
        switch hexString.count {
        case 6: // RRGGBB
            red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
            green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
            blue = CGFloat(rgbValue & 0x0000FF) / 255.0
            alphaValue = alpha ?? 1.0
            
        case 8: // RRGGBBAA
            red = CGFloat((rgbValue & 0xFF000000) >> 24) / 255.0
            green = CGFloat((rgbValue & 0x00FF0000) >> 16) / 255.0
            blue = CGFloat((rgbValue & 0x0000FF00) >> 8) / 255.0
            alphaValue = alpha ?? CGFloat(rgbValue & 0x000000FF) / 255.0
            
        default:
            // Default to black if invalid format
            red = 0
            green = 0
            blue = 0
            alphaValue = alpha ?? 1.0
        }
        
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alphaValue)
    }
}
