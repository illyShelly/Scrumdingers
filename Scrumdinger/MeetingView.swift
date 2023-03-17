//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Ilona Sellenberkova on 17/03/2023.
//

import SwiftUI

//1st 'structure' conforms to the 'View protocol', which has a single requirement: a 'body' property that returns a View. In the body property, you describe the content, layout, and behavior of the view

struct MeetingView: View {
    var body: some View {
        ProgressView(value: 5, total: 15)  // display the percentage of time elapsed during the scrum
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView()
    }
}
