//
//  MeetingFooterView.swift
//  Scrumdinger
//
//  Created by Ilona Sellenberkova on 25/03/2023.
//

import SwiftUI

struct MeetingFooterView: View {
    let speakers: [ScrumTimer.Speaker]
    
    var skipAction: ()->Void // skipAction closure property
    
    // ScrumTimer marks each speaker as completed when their time has ended. The first speaker not marked as completed becomes the active speaker. The speakerNumber property uses the index to return the active speaker number, which you’ll use as part of the footer text.
    private var speakerNumber: Int? {
        guard let index = speakers.firstIndex(where: { !$0.isCompleted }) else { return nil }
        return index + 1 // in text number is 1+
    }
    
    // Add a private computed property that checks whether the active speaker is the last speaker.
    // This property is true if the isCompleted property of each speaker except the last speaker is true.
    private var isLastSpeaker: Bool {
        // .allSatisfy - every element of a sequence satisfies a given predicate
        return speakers.dropLast().allSatisfy( { $0.isCompleted } )
        // or
//         speakers.dropLast().reduce(true) { $0 && $1.isCompleted }
    }
    
    // returns Speaker X of Y when there are remaining speakers or No more speakers when the meeting exceeds the allotted time.
    // Above variable - 'nil' or 'index'
    private var speakerText: String {
            guard let speakerNumber = speakerNumber else { return "No more speakers" }
            return "Speaker \(speakerNumber) of \(speakers.count)"
    }
    
    var body: some View {
        VStack {
            
            // Add an HStack with a text view that displays “Speaker 1 of 3”
            HStack {
                if isLastSpeaker {
                    Text("Last Speaker")
                } else {
                    Text(speakerText)
                    Spacer()
                    
                    Button(action: skipAction) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next speaker")
                }
               
            }
        }
        .padding([.bottom, .horizontal])
    }
}

struct MeetingFooterView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingFooterView(speakers: DailyScrum.sampleData[0].attendees.speakers,
                          skipAction: {})
        // allow users to skip to the next speaker.
        // thanks to extention in the ScrumTimer class, an array of speakers using the speakers property on DailyScrum.attendees.
            .previewLayout(.sizeThatFits)
    }
}
