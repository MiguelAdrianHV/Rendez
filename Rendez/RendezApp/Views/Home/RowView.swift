//
//  RowView.swift
//  Rendez
//
//  Created by Miguel Hernandez on 5/30/23.
//

import SwiftUI

struct RowView: View {
    
    var event: Event
    
    var body: some View {
        VStack (alignment: .leading, spacing: 6){
            
            HStack {
                Image("event-party-portada")
                    .resizable()
                    .scaledToFit()
                    .previewLayout(.fixed(width: 400, height: 350))
            }
            VStack(alignment: .leading){
                HStack {
                    Text(event.theme)
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                }
                Text(event.name)
                    .font(.title)
            }
            .padding()
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(event:  Event(id: "1", name: "Powder Party", theme: "Party", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", image: "party.popper.fill"))
    }
}
