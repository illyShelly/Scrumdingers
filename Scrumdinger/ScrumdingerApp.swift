//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Ilona Sellenberkova on 17/03/2023.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
// The app’s 'body property' returns a 'Scene' that contains a view hierarchy representing the primary user interface for the app
    
    // 2nd Binding down the hierarchy
    @State private var scrums = DailyScrum.sampleData

    var body: some Scene {
        WindowGroup {
            //            WindowGroup is 'one of the primitive scenes' that SwiftUI provides. In iOS, the views you add to the WindowGroup scene builder are presented in 'a window that fills entire screen'.
            NavigationView {
                // ScrumsView(scrums: DailyScrum.sampleData) // the app’s root view
                ScrumsView(scrums: $scrums)
            }
        }
    }
}
