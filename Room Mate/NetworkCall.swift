//
//  NetworkCall.swift
//  Room Mate
//
//  Created by Seth Arvila on 3/27/24.
//

import Foundation


func getEvent() async throws -> ([AAEvent]) {
    var events: [AAEvent] = []
    let endPoint = "https://www.aaiscloud.com/NDUSystemOffice/~api/calendar/calendarList?action=get&view=JSON&fields=CampusName%2CLocation.RoomId%2C%20%20LocationName%2CBuildingCode%2CRoomName%2CEventId%2CActivityName%2CStartDateTime%2CEndDateTime&limit=10000&filter=(((StartDateTime%3E%3D%222024-04-01%22)%26%26(EndDateTime%3C%3D%222024-04-15%22))%26%26CampusName%20in%20(%20%20%22NDSU1%22%20%20))"
    
/* let roomInfoEndpoint = "https://www.aaiscloud.com/NDUSystemOffice/~api/query/room?fields=Id,Building.Name,Building.Campus.Name,Name,MaxOccupancy"
 */
    
    // -- Query the API, redirect to login site. Pull those cookies --
    guard let url = URL(string: endPoint) else {throw AAError.invalidURL}                   // Build the URL for the query
    let (_, response) = try await URLSession.shared.data(from: url)                         // URL Session to get guest session cookies
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {    // Check that the response was good
        throw AAError.invalidResponse
    }
    
    // Take the cookies from the previous session and add then to Cookie Storage
    if  let url = response.url,
        let allHeaderFields = response.allHeaderFields as? [String : String] {
        let cookies = HTTPCookie.cookies(withResponseHeaderFields: allHeaderFields, for: url)
        for cookie in cookies{
            HTTPCookieStorage.shared.setCookie(cookie)
        }
    }
    
    
    let (data1, _) = try await URLSession.shared.data(from: url) // Using the new cookies, query the API again. save to data1

    // Parse the event result
    do {
        let aaDecoder = JSONDecoder()
        let decodedData: AAEventResponse = try aaDecoder.decode(AAEventResponse.self, from: data1)
        
        // Decode the events, store them in the events array
        for i in 0...(decodedData.totalRecords - 1) {
            let myActivityName: String = (String(decodedData.data[i][6] ?? "nil"))
            let myLocationName: String = (String(decodedData.data[i][2] ?? "nil"))
            let myLocationRoomID: UUID = UUID(uuidString: (String(decodedData.data[i][1] ?? "nil"))) ?? UUID()
            let myStartDateString: String = String(decodedData.data[i][7] ?? "nil")
            let myEndDateString: String = String(decodedData.data[i][8] ?? "nil")
            let myBuildingCode: String = String(decodedData.data[i][3] ?? "nil")
            let myRoomName: String = String(decodedData.data[i][4] ?? "nil")
            let myCampusName: String = String(decodedData.data[i][0] ?? "nil")

            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let myStartDate = dateFormatter.date(from:myStartDateString)!
            let myEndDate = dateFormatter.date(from:myEndDateString)!

            
            let myEvent: AAEvent = AAEvent(ActivityName: myActivityName, StartDateTime: myStartDate, EndDataTime: myEndDate, locationName: myLocationName, RoomId: myLocationRoomID, BuildingCode: myBuildingCode, RoomName: myRoomName, CampusName: myCampusName)
            
            events.append(myEvent)
        }
    } catch {
        print(error)
    }
    print("Network Call Complete")
    return(events)
}





// Struct to represent the format that the endpoint provides
struct AAEventResponse: Codable {
    let totalRecords: Int
    let data: [[String?]]
}

// Struct to represent an event
struct AAEvent: Codable, Identifiable {
    var id: UUID = UUID()
    let ActivityName: String?
    let StartDateTime: Date?
    let EndDataTime: Date?
    let locationName: String?
    let RoomId: UUID?
    let BuildingCode: String?
    let RoomName: String?
    let CampusName: String?
    
}

enum AAError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
