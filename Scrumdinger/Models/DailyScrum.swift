//
//  DailyScrum.swift
//  Scrumdinger
//
//  Created by Ilona Sellenberkova on 19/03/2023.
//

import Foundation

//Because DailyScrum will primarily carry value data, you’ll make it a value type by declaring it as a struct.

struct DailyScrum {
    var title: String
    var attendees: [String]
    var lengthInMinutes: Int
    var theme: Theme
}

// extension that provides some sample data.

extension DailyScrum {
    static let sampleData: [DailyScrum] = [
        DailyScrum(title: "Design", attendees: ["Cathy", "Daisy", "Simon", "Jonathan"], lengthInMinutes: 10, theme: .yellow),
        DailyScrum(title: "App Dev", attendees: ["Katie", "Gray", "Euna", "Luis", "Darla"], lengthInMinutes: 5, theme: .orange),
        DailyScrum(title: "Web Dev", attendees: ["Chella", "Chris", "Christina", "Eden", "Karla", "Lindsey", "Aga", "Chad", "Jenn", "Sarah"], lengthInMinutes: 5, theme: .poppy)
    ]
}
