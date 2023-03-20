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
    var attendees: [String]
    var lengthInMinutes: Int
    var theme: Theme
    
    
    //if I don't make an instance UUID() then I need initializer. Your code still won’t compile because the DailyScrum initializers in the data array don’t include an id argument.
//    Initialize here and I DON'T HAVE TO DO IT SEPARATELY IN SAMPLEDATA AS:  id: 1, ...'
    
//    When you define a default value for a parameter, you can omit that parameter when you call an initializer or function
    init(id: UUID = UUID(), title: String, attendees: [String], lengthInMinutes: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.attendees = attendees
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
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
