//
//  ContentView.swift
//  Room Mate
//
//  Created by Seth Arvila on 2/26/24.
//

import SwiftUI

struct ContentView: View {
    @State var events: [AAEvent] = []
//    @State var rooms: [AARoom] = []
    
    var body: some View {
        
        NavigationStack {
            VStack (alignment: .center){
                List(events) { event in
                    EventRow(event: event)
                }
                .listStyle(.plain)
                Button {
                    Task {
                        try await (events) = getEvent()
                    }
                } label: {
                    Text("Get Data")
                }
                .buttonStyle(.bordered)
                
               

            }
            .navigationTitle("NDUS Events")
        }
        
    }
    
    
    
}

#Preview {
    ContentView()
}







