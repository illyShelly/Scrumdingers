//
//  Theme.swift
//  Scrumdinger
//
//  Created by Ilona Sellenberkova on 19/03/2023.
//

import Foundation
import SwiftUI

//not creating a view in this section, you add Color properties from the SwiftUI framework. SwiftUI treats colors as View instances that you can add directly to a view hierarchy


// Swift automatically creates 'strings' from each case name in Theme.
//In AssetsCatalog Themes folder -> RGBA values for each color
enum Theme: String {
    case bubblegum
    case buttercup
    case indigo
    case lavender
    case magenta
    case navy
    case orange
    case oxblood
    case periwinkle
    case poppy
    case purple
    case seafoam
    case sky
    case tan
    case teal
    case yellow
    
//    Add a 'Color' property named 'accentColor' that returns .black or .white depending on the value of self.
//    The accent color provides a high-contrast complement to the theme’s main color, ensuring your views remain accessible.
    var accentColor: Color {
        switch self {
        case .bubblegum, .buttercup, .lavender, .orange, .periwinkle, .poppy, .seafoam, .sky, .tan, .teal, .yellow: return .black
        case .indigo, .magenta, .navy, .oxblood, .purple: return .white
        }
    }
    
//    Add a 'Color' property named 'mainColor' that 'creates a color using the enumeration’s rawValue'.
//    This property initializes a color from the asset catalog.
    var mainColor: Color {
        Color(rawValue)
    }
    
//    capitalize the Theme enumeration cases for UI
    var name: String {
        rawValue.capitalized
    }
}
