//
//  ListDetailView.swift
//  Rendez
//
//  Created by Miguel Hernandez on 5/30/23.
//

import SwiftUI

struct ListDetailView: View {
    
    var event: Event
    
    var body: some View {
        VStack {
            event.image
                .resizable()
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 4))
                .shadow(color: Color.gray, radius: 5)
            HStack {
                Text(event.name)
            }
                .font(.title)
            Text(event.theme)
                
                
        }
    }
}

struct ListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ListDetailView(event: Event(id: 1, name: "Como cocinar un huevo", theme: "Cocina", image: Image(systemName: "frying.pan")))
    }
}
