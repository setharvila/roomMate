//
//  EventRow.swift
//  Room Mate
//
//  Created by Seth Arvila on 3/27/24.
//

import SwiftUI

struct EventRow: View {
    var event: AAEvent = AAEvent(ActivityName: "Name", StartDateTime: Date(), EndDataTime: Date(), locationName: "Room 123", RoomId: UUID(), BuildingCode: "BLDG", RoomName: "123", CampusName: "UNI")

    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading){
                Text("\(event.ActivityName ?? "Name")")
                    .fontWeight(.medium)
                Text("\(event.StartDateTime ?? Date(), style: .date) - \(event.StartDateTime ?? Date(), style: .time) - \(event.EndDataTime ?? Date(), style: .time)")
                    .font(.caption)
                    
            }
            
            
            HStack {
                Text("\(event.locationName ?? "Unkown Location")")
                    .font(.caption)
                Spacer()
//                Text("Room ID: \(eventRoomID)")
//                    .font(.caption)
            }
            HStack {
                Text(event.RoomId?.uuidString ?? "No Room ID")
                    .font(.caption)
                Spacer()
//                Text("Room ID: \(eventRoomID)")
//                    .font(.caption)
            }
        }
//        .padding()
    
        
    }
}

#Preview {
    EventRow()
}
