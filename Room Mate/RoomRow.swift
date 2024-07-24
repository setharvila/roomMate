//
//  RoomRow.swift
//  Room Mate
//
//  Created by Seth Arvila on 4/3/24.
//

import SwiftUI

struct RoomRow: View {
//    var room: AARoom = AARoom(buildingName: "BLDG", campusName: "UNI", roomName: "123")
    var body: some View {
        VStack(alignment: .leading) {
            HStack(){
                Text("\("BLDG") \("123")")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                
            }
            HStack(){
                Text("\("Univ01")")
                Spacer()
                
                
            }

            
        }   
    }
}

#Preview {
    RoomRow()
}
