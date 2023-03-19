//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Ilona Sellenberkova on 17/03/2023.
//

import SwiftUI

//1st 'structure' conforms to the 'View protocol', which has a single requirement: a 'body' property that returns a View. In the body property, you describe the content, layout, and behavior of the view

struct MeetingView: View {
    var body: some View {
        VStack {
            ProgressView(value: 5, total: 15) // 1.
            
            HStack {
                // These alignments override the default behavior, which is center alignment.
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    
                    Label("300", systemImage: "hourglass.bottomhalf.fill")
                }
                
                Spacer()
                
                
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                        .font(.caption)
                    
                    Label("600", systemImage: "hourglass.tophalf.fill")

                }
            }
            
            Circle()
                .strokeBorder(lineWidth: 24)
            
// Add an HStack with a text view that displays “Speaker 1 of 3”
            HStack {
                Text("Speaker 1 of 3")
                Spacer()
                Button(action: {}) {
                    Image(systemName: "forward.fill")
                }

            }
        }
        .padding()
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView()
    }
}

//1. display the percentage of time elapsed during the scrum
