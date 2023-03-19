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
            
            //Spacer()
            
            HStack {
                Label("\(scrum.attendees.count)", systemImage: "person.3")
                Spacer()
                Label("\(scrum.lengthInMinutes)", systemImage: "clock")
                    .padding(.trailing, 20)
            }
                .font(.caption)
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
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
