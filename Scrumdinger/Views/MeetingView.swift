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
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
            
            VStack {
//                MeetingHeaderView(secondsElapsed: <#Int#>, secondsRemaining: <#Int#>)
                
                Circle()
                    .strokeBorder(lineWidth: 24)
                
                // Add an HStack with a text view that displays “Speaker 1 of 3”
                HStack {
                    Text("Speaker 1 of 3")
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next speaker")
                }
            }
            //            .padding()
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
//        pass a constant scrum binding in the MeetingView() initializer.
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}

