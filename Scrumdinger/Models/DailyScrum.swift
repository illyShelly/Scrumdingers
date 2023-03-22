//
//  DailyScrum.swift
//  Scrumdinger
//
//  Created by Ilona Sellenberkova on 19/03/2023.
//

import Foundation
import SwiftUI

//Because DailyScrum will primarily carry value data, you’ll make it a value type by declaring it as a struct.

struct DailyScrum: Identifiable {
    var id: UUID //= UUID()
    var title: String
    var attendees: [Attendee] // [String]
    var lengthInMinutes: Int
    var theme: Theme
    
    
    // if I don't make an instance UUID() then I need initializer. Your code still won’t compile because the DailyScrum initializers in the data array don’t include an id argument.
    // Initialize here and I DON'T HAVE TO DO IT SEPARATELY IN SAMPLEDATA AS:  id: 1, ...'
    
//    When you define a default value for a parameter, you can omit that parameter when you call an initializer or function
    init(id: UUID = UUID(), title: String, attendees: [String], lengthInMinutes: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.attendees = attendees.map { Attendee(name: $0) } // a new array of the instances of the Attendees
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
//    map the attendee names array to the values of the Attendee type in the initializer.
//    map(_:) creates a new collection by iterating over and applying a transformation to each element in an existing collection.attendees
}

//To confirm Identifiable to iterate through the attendies in the View
// create an extension with an inner structure named Attendee that is identifiable.
extension DailyScrum {
    struct Attendee: Identifiable {
        let id: UUID // = UUID()
        var name: String
        
//        Add an initializer that assigns a default value to the id property.
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
    
//    Users adjust a meeting’s 'length' with a 'Slider view'. Sliders work with Double, you define lengthInMinutes as a Double.
//    By making 'Data a nested type', you keep DailyScrum.Data distinct from the Data structure defined in the Foundation framework.
//    Assign default values to all properties.
    
//    If all properties have default values, the compiler creates an initializer that takes no arguments. With this initializer, you can create a new instance by calling Data()
    struct Data {
        var title: String = ""
        var attendees: [Attendee] = []
        var lengthInMinutes: Double = 5.0
        var theme: Theme = .seafoam
    }
    
//    Add a' computed data property' that returns Data with the DailyScrum property values.
    var data: Data {
        Data(title: title, attendees: attendees, lengthInMinutes: Double(lengthInMinutes), theme: theme)
    }
}

// extension that provides some sample data.

extension DailyScrum {
    static let sampleData: [DailyScrum] = [
        DailyScrum(title: "Design", attendees: ["Cathy", "Daisy", "Simon", "Jonathan"], lengthInMinutes: 10, theme: .yellow),
        DailyScrum(title: "App Dev", attendees: ["Katie", "Gray", "Euna", "Luis", "Darla"], lengthInMinutes: 5, theme: .poppy),
        DailyScrum(title: "Web Dev", attendees: ["Chella", "Chris", "Christina", "Eden", "Karla", "Lindsey", "Aga", "Chad", "Jenn", "Sarah"], lengthInMinutes: 5, theme: .periwinkle),
        DailyScrum(title: "Game", attendees: ["Lindsey", "Aga", "Chad", "Jenn", "Sarah"], lengthInMinutes: 5, theme: .seafoam)
    ]
}
