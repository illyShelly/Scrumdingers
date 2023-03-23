//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Ilona Sellenberkova on 20/03/2023.
//

import SwiftUI
//About @State and @BindingA
//@Binding doesn’t store the data directly. Instead, it creates a two-way connection between an existing source of truth and a view that displays and updates that data. This connection ensures that multiple views associated with a piece of data are in sync.

struct DetailView: View {
    @Binding var scrum: DailyScrum // for update method change to 'var'
        
//    The empty initializer creates an instance with default values for its properties. You’ll update these values to match the selected scrum when the user taps the Edit button.
    @State private var data = DailyScrum.Data() // moved source of truth
//    Using a binding ensures that DetailView renders again when the user’s interaction modifies scrum.
    
    @State private var isPresentingEditView: Bool = false
    
    var body: some View {
        // to display static subviews in a single column with rows.
        List {
            // create visual distinctions within your list. They help you to chunk content and establish groups in the list
            Section(header: Text("Meeting Info")) {
                
                // Redirect into Meeting timer screen
                NavigationLink {
                    MeetingView() // as destination closure
                } label: {
                    Label("Start Meeting", systemImage: "timer") // later it will navigate users to the meeting view.
                        .font(.headline)
                        .foregroundColor(.accentColor) // colour of interactive element
                        .accessibilityLabel("Click to start Meeting")
                }

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
                // now array of instances of Attendee
                ForEach(scrum.attendees, id: \.id) { attendee in
                    Label("\(attendee.name)", systemImage: "person")
                }
            }
            
        }
        .navigationTitle(scrum.title)
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                data = scrum.data // set data to scrum.data
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            // showup modal when 'edit'
            NavigationView {
                
                DetailEditView(data: $data) // update to bind data from edit view to detail view
                
                    .navigationTitle(scrum.title)
                    // toolbar button - canceling changes to the scrum details. Dismiss DetailEditView in the Cancel button action.
                    
                    .toolbar {
                        // cancalation action for the modal interface
                        ToolbarItem(placement: .cancellationAction) {
                           Button("Cancel") {
                               isPresentingEditView = false
                           }
                       }
                        
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                // update data when click on Done
                                scrum.update(from: data)
                            }
                        }
                    }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
// pass a constant binding to the DetailView initializer in DetailView_Previews.
//            DetailView(scrum: DailyScrum.sampleData[0])
            DetailView(scrum: .constant(DailyScrum.sampleData[0]))
        }
    }
}

// By default, VoiceOver reads the title of the Label. If you want VoiceOver to convey more detail, replace the default spoken text by adding an accessibilityLabel that describes the element.
// 3. Add accessibilityElement(children:) to the HStack to combine the Label and Text elements for accessibility users.
// VoiceOver then reads the two elements as one statement, for example, “Length, 10 minutes.” Without the modifier, VoiceOver's users have to swipe again between each element.
