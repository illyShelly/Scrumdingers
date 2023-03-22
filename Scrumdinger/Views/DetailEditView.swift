//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by Ilona Sellenberkova on 21/03/2023.
//

import SwiftUI

struct DetailEditView: View {
// As private so they can be accessed only within the view in which you define them
    @State private var data = DailyScrum.Data()
    @State private var newAttendeeName = ""
    
    var body: some View {
        // Form and add a Section with a “Meeting Info” header.
        Form {
            Section(header: Text("Meeting Info")) {
                TextField("Title", text: $data.title)
                //takes a binding to a String. The current view manages the state of the 'data property'
                
                // 2. Add an HStack and a Slider for the meeting length. In the slider’s label closure, add a Text view for accessibility use. 5-30 min, increase by 1 min.
                // A Slider stores a Double from a continuous range that you specify. Passing a step value of 1 limits the user to choosing whole numbers
                // The Text view won’t appear on screen, but VoiceOver uses it to identify the purpose of the slider.
                HStack {
                    Slider(value: $data.lengthInMinutes, in: 5...30, step: 1) {
                        // label input
                        Text("Length of time")
                    }
                    .accessibilityValue("\(Int(data.lengthInMinutes)) minutes")
                }
                Spacer()
                // Display length of the meeting String(format: "%.2f", myDouble)
                // or simply into Int(data.lengthInMinutes)
                Text("\(String(format: "%.0f", data.lengthInMinutes)) minutes")
                    .accessibilityHidden(true) // hide text from VoiceOver - in Slider
            }
            
            Section(header: Text("Attendees")) {
                ForEach(data.attendees) { attendee in
                    Text(attendee.name)
                }
                // Remove attendees from the scrum data.
                // The framework calls the closure you pass to onDelete when the user swipes to delete a row.
                .onDelete { indices in
                    data.attendees.remove(atOffsets: indices)
                }
                
                // The binding keeps newAttendeeName in sync with the contents of the text field. It doesn’t affect the original DailyScrum model data
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)
            
                    // Add an animation block that 'creates a new attendee' and 'appends' the new attendee to the attendees array
                    Button(action: {
                        withAnimation {
                            let attendee = DailyScrum.Attendee(name: "\(newAttendeeName)")
                            data.attendees.append(attendee)
                            newAttendeeName = ""
                            // text field has a binding to newAttendeeName, setting the value to the empty string also clears the contents of the text field.
                        }
                    }) {
                        Image(systemName: "plus.circle.fill") // Image as a label
                            .accessibilityLabel("Add Attendee") // label for Image
                    }
                    // modifier prevents users from mistakenly saving an attendee without a name.
                    .disabled(newAttendeeName.isEmpty)
                }

            }
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView()
    }
}
