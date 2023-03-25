//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Ilona Sellenberkova on 17/03/2023.
//

import SwiftUI

//1st 'structure' conforms to the 'View protocol', which has a single requirement: a 'body' property that returns a View. In the body property, you describe the content, layout, and behavior of the view

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    @StateObject var scrumTimer: ScrumTimer = ScrumTimer() // property of timer
    // view owns the source of truth for the object. @StateObject ties the ScrumTimer, which is an ObservableObject, to the MeetingView life cycle

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)

            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, theme: scrum.theme)

                Circle()
                    .strokeBorder(lineWidth: 24, antialiased: true)

                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
            //            .padding()
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        // The timer resets each time an instance of MeetingView shows on screen, indicating that a meeting should begin.
        .onAppear {
            scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
            scrumTimer.startScrum()
            // start a new scrum timer after the timer resets.
        }
        // The timer stops each time an instance of MeetingView leaves the screen, indicating that a meeting has ended.
        .onDisappear {
            scrumTimer.stopScrum()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
//        pass a constant scrum binding in the MeetingView() initializer.
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
