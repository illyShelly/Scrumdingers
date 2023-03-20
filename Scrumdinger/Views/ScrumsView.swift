//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Ilona Sellenberkova on 19/03/2023.
//

import SwiftUI

struct ScrumsView: View {
    var scrums: [DailyScrum]
    
    var body: some View {
// Accepts a 'ViewBuilder' as its only 'parameter'. So, you can add 'rows' with the same syntax you’ve been using with other container views such as 'HStack and VStack'
// List(scrums) { scrum in || List { ForEach(scrums, id:\.title)

//        After the scruct confirms Identifiable and add the Initilize 'id' -> I can omit that: 'id: \.id'
        List(scrums) { scrum in
            // Initialize a CardView in the closure for each element in the scrums array
            
            // The destination presents a 'single view' in the navigation hierarchy when a user interacts with the element. Each 'row' pushes to an 'individual destination'. SwiftUI automatically adds the 'Back button' in the detail view and fills in the title of the previous screen.
            
            NavigationLink(destination: Text(scrum.title)) {
                CardView(scrum: scrum)
            }
            .listRowBackground(scrum.theme.mainColor)

        }
        .navigationTitle("Daily Scrums")
        
        // Add a toolbar, and 'add a Button' toolbar item that displays the 'plus icon'. Pass an empty action to the button for now.
        .toolbar {
            Button(action: {}) {
                Image(systemName: "plus")
            }
            .accessibilityLabel("Add New Scrum")

        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var scrumsArr: [DailyScrum] = DailyScrum.sampleData
    
    static var previews: some View {
//        Adding the NavigationView displays navigation elements, like title and bar buttons, on the canvas
        NavigationView {
            ScrumsView(scrums: scrumsArr)
                .navigationTitle("Scrums")
        }
    }
}


// Add a ForEach view. Pass the scrums array and a key path to the title property to the initializer.
//        ForEach needs a way to 'identify individual items' in the collection.
//        For now, because all of the scrums in the test data have different names, you can use the title property to identify each item.
