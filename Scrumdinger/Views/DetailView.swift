//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Ilona Sellenberkova on 20/03/2023.
//

import SwiftUI

struct DetailView: View {
    let scrum: DailyScrum
    
    var body: some View {
        // to display static subviews in a single column with rows.
        List {
            // create visual distinctions within your list. They help you to chunk content and establish groups in the list
            Section(header: Text("Meeting Info")) {
                
                Label("Start Meeting", systemImage: "timer") // later it will navigate users to the meeting view.
                    .font(.headline)
                    .foregroundColor(.accentColor) // colour of interactive element
                    .accessibilityLabel("Click to start Meeting")
                
                // 3. Create an HStack, and add a Label with the clock icon for the meeting length.
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                .accessibilityElement(children: .combine)
               
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    // show which theme is active
                    Text("\(scrum.theme.name)")
                        .padding(5)
                        .foregroundColor(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(5)
                }
                .accessibilityElement(children: .combine) //for voiceOver
            }
            
//            2nd Section - Atendees
            Section(header: Text("Atendees")) {
            // cannot use Identifiable for String -> made Struct of Attendees
//                ForEach(scrum.attendees, id: \.id) { attendee in
//                    Text(attendee)
//                }
            }
        }
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(scrum: DailyScrum.sampleData[0])
        }
    }
}

// By default, VoiceOver reads the title of the Label. If you want VoiceOver to convey more detail, replace the default spoken text by adding an accessibilityLabel that describes the element.
// 3. Add accessibilityElement(children:) to the HStack to combine the Label and Text elements for accessibility users.
// VoiceOver then reads the two elements as one statement, for example, “Length, 10 minutes.” Without the modifier, VoiceOver's users have to swipe again between each element.
