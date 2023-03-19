//
//  TrailingIconLabelStyle.swift
//  Scrumdinger
//
//  Created by Ilona Sellenberkova on 19/03/2023.
//

import Foundation
import SwiftUI

// Label style to stack the scrum length and clock icon horizontally. With the LabelStyle protocol, you can create a consistent design throughout your app by reusing the same label style for several views

struct TrailingIconLabelStyle: LabelStyle {
//    The system calls this method 'for each Label instance' in a view hierarchy where this style is the current label style.
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

//create static property for LabelStyle
extension LabelStyle where Self == TrailingIconLabelStyle {
//    you defined the label style as a 'static' property, you 'can call it using leading-dot' syntax, which makes your code more readable
    static var trailingIcon: Self { Self() }
}

//the configuration is: 'parameter' is a 'LabelStyleConfiguration', which contains the 'icon and title views'. These views 'represent' the label’s 'image' and label 'text'

// If you don’t want to create a custom label style, you can use one of the built-in label styles that display the icon, the title, or both using a system-standard layout.
