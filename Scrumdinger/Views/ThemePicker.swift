//
//  ThemePicker.swift
//  Scrumdinger
//
//  Created by Ilona Sellenberkova on 23/03/2023.
//

import SwiftUI

//Instead of creating a new source of truth for the theme picker, you’ll use a binding that references a theme structure defined in the parent view.

struct ThemePicker: View {
    // This binding communicates changes to the theme within the theme picker, back to the parent view.
     @Binding var selection: Theme
    
    var body: some View {
        // The picker will display all available themes. You’ll make Theme conform to CaseIterable so that you can easily access all the enumeration’s cases
        Picker("Theme", selection: $selection) {
            // add a ForEach to 'list all cases' of Theme
            ForEach(Theme.allCases) { theme in
                // Add a 'ThemeView' and 'tag it' with the theme
                ThemeView(theme: theme)
                    .tag(theme)  // You can tag subviews when you need 'to differentiate among them' in controls like pickers and lists.
                        // Tag values can be 'any hashable type' like in -> an enumeration
            }
        }
    }
}

struct ThemePicker_Previews: PreviewProvider {
    static var previews: some View {
        ThemePicker(selection: .constant(Theme.tan))
        // the constant(_:) type method to create a binding to a hard-coded, immutable value. Constant bindings are useful in previews or when prototyping your app’s UI.
    }
}
