//
//  BuildingCard.swift
//  Room Mate
//
//  Created by Seth Arvila on 3/11/24.
//

import SwiftUI

struct BuildingCard: View {
    var body: some View {
        VStack(alignment: .leading, content: {
            
            Image("building-1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 150)
                .clipped()
                .clipShape(.rect(cornerRadius: 25.0))
            Text("AGHC")
                .font(.title2)
                .fontWeight(.semibold)
            Text("20 Rooms")
                .font(.subheadline)
        })
        .padding()
        .clipShape(.rect(cornerRadius: 25.2))
    }
}

#Preview {
    BuildingCard()
}
