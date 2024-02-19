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
        VStack (alignment: .leading, spacing: 1){
            
            HStack {
                Image(uiImage: event.image)
                    .resizable()
                    .frame(width: UIScreen.screenWidth*0.80, height: 225)
                    .scaledToFit()
                    .cornerRadius(20.0)
                    
                    
            }
            VStack(alignment: .leading){
                HStack {
                    Text(event.theme)
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                }
                Text(event.name)
                    .font(.title)
                    .foregroundColor(Color.black)
            }
            .padding()
        }
        .frame(width: UIScreen.screenWidth*0.80, height: 315)
        .padding()
        .background(Color.white)
        .cornerRadius(20.0)
        
    }
        
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(event:  Event(id: "1", name: "Powder Party", theme: "Party", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", image: UIImage( imageLiteralResourceName: "event-party-portada"), eventDate: "2020"))
    }
}
