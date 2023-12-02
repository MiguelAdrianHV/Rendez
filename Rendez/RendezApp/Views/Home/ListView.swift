//
//  ListView.swift
//  Rendez
//
//  Created by Miguel Hernandez on 5/30/23.
//

import SwiftUI

final class EventsModelData: ObservableObject {
 @Published var events = [Event(id: 0, name: "Como cocinar un huevo", theme: "Cocina", image: Image(systemName: "frying.pan")),
                          Event(id: 1, name: "Como relajarse mejor", theme: "Yoga", image: Image(systemName: "figure.mind.and.body")),
                          Event(id: 2, name: "Bootcamp de iOS", theme: "Programacion", image: Image(systemName: "laptopcomputer")),
                          Event(id: 3, name: "Carrera 5KM", theme: "Deporte", image:Image(systemName: "figure.run"))]
}

struct ListView: View {
    
    @EnvironmentObject var eventsModelData: EventsModelData
    @State private var showFavorites = false
    
    
    var body: some View {
            NavigationView {
                VStack {
                    
                    List(eventsModelData.events, id: \.id) {
                    event in
                    NavigationLink(destination: ListDetailView(event: event)){
                        RowView(event: event)
                    }
                }
                .navigationTitle("Events")
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView().environmentObject(EventsModelData())
    }
}
