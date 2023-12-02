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
        RowView(event:  Event(id: 1, name: "Powder Party", theme: "Party", image: Image(systemName: "party.popper.fill")))
            .previewLayout(.fixed(width: 400, height: 350))
    }
}
