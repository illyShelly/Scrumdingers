//
//  MeetingHeaderView.swift
//  Scrumdinger
//
//  Created by Ilona Sellenberkova on 25/03/2023.
//

import SwiftUI

struct MeetingHeaderView: View {
    let secondsElapsed: Int
    let secondsRemaining: Int
    let theme: Theme
    
//    computed property
    private var totalSeconds: Int {
        secondsElapsed + secondsRemaining
    }
//    Add a private computed property that calculates 'progress' and pass to ProgressView -> part of total
    private var progress: Double {
        guard totalSeconds > 0 else { return 1 }
        return Double(secondsElapsed) / Double(totalSeconds)
    }
//    computed property that calculates the minutesRemaining using the secondsRemaining value.
    private var minutesRemaining: Int {
       secondsRemaining / 60
    }
    
    var body: some View {
        VStack {
//            custom style to draw a background view in either black or white around the ProgressView to give the view more visual emphasis.
            ProgressView(value: progress)
                .progressViewStyle(ScrumProgressViewStyle(theme: theme))
            
            HStack {
                // These alignments override the default behavior, which is center alignment.
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    Label("\(secondsElapsed)", systemImage: "hourglass.bottomhalf.fill")
                }
                
                Spacer()
                
                
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                        .font(.caption)
                    Label("\(secondsRemaining)", systemImage: "hourglass.tophalf.fill")
                        .labelStyle(.trailingIcon)
                    // The default Label style shows the Image and Text in the wrong order for the design. The custom TrailingIconLabelStyle reverses the order of the two views.
                    
                }
            }
        }
        // Ignore the inferred accessibility labels and values for the child views. By default reads system Views "hourglass.fill"
        // rather than force VoiceOver users to listen to the output of both labels, create only one
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Time remaining")
        .accessibilityValue("\(minutesRemaining) minutes")
        .padding([.top, .horizontal])

    }
}

struct MeetingHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingHeaderView(secondsElapsed: 60, secondsRemaining: 180, theme: .bubblegum)
            .previewLayout(.sizeThatFits)
    }
}

//1. display the percentage of time elapsed during the scrum
//ProgressView(value: 5, total: 15)

//Because VoiceOver users don’t have the visual reference of the progress view or progress ring, you’ll calculate the conversion from seconds to minutes and surface the most relevant data — the minutes remaining.
