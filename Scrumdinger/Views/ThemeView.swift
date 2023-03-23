//
//  ThemeView.swift
//  Scrumdinger
//
//  Created by Ilona Sellenberkova on 22/03/2023.
//

import SwiftUI

// Might define a list cell in the same file as the list view structure. By defining the cell in a separate file, you can more easily reuse it in a future project.

struct ThemeView: View {
    // Create a theme 'constant' and pass a value in the preview.
    // Single instance of Theme.
    let theme: Theme
    
    var body: some View {
        // Display the theme name and colors.
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(theme.mainColor)
            
            // Label that displays the theme name and the paintpalette system image
            Label("\(theme.name)", systemImage: "paintpallete")
                .padding(4)
        }
        // Low contrast between the theme’s main color and the default label text color can make this view difficult to read.
        .foregroundColor(theme.accentColor)
        .fixedSize(horizontal: false, vertical: true) // display as the nudle
        
    }
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView(theme: Theme.buttercup) // or just .buttercup
    }
}


// ZStack overlays views back to front, the RoundedRectangle acts as a background and appears behind the views listed below it.
