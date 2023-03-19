//
//  CardView.swift
//  Scrumdinger
//
//  Created by Ilona Sellenberkova on 19/03/2023.
//

import SwiftUI

struct CardView: View {
    
    var scrum: DailyScrum // constant named scrum of type DailyScrum.
    
    var body: some View {
        // VStack arranges child views in a vertical line and takes an alignment argument to position views along the horizontal axis
        VStack(alignment: .leading) {
            Text(scrum.title)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            
            //Spacer()
            
            HStack {
                Label("\(scrum.attendees.count)", systemImage: "person.3")
                    .accessibilityLabel("\(scrum.attendees.count) attendees") // describes the contents of the first Label
                
                Spacer()
                
                Label("\(scrum.lengthInMinutes)", systemImage: "clock")
                    .accessibilityLabel("\(scrum.lengthInMinutes) minute meeting")

                    .labelStyle(.trailingIcon)  // The clock icon now aligns on the trailing edge, mirroring the leading label for the number of attendees.

            }
                .font(.caption)
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
//        .foregroundColor(scrum.color.accessibleFontColor)

    }
}

struct CardView_Previews: PreviewProvider {
    static var scrum = DailyScrum.sampleData[0]
    
    static var previews: some View {
        CardView(scrum: scrum)
            .background(scrum.theme.mainColor)
            .previewLayout(.fixed(width: 400, height: 60))
        
//        Setting the preview layout and background color presents CardView as it’ll appear inside a List view.
    }
}
