//
//  EventsViewModel.swift
//  Rendez
//
//  Created by Miguel Hernandez on 11/29/23.
//

import Foundation
import SwiftUI
import Firebase

@MainActor
class EventsViewModel: ObservableObject {
    @Published var homeViewEvents: [Event]?
    
    private let db = Firestore.firestore()
    init() {
        Task {
            await fetchHomeEvents()
        }
    }
    
    func createEvent(withName: String, theme: String, description: String, image: String) async throws{
        do {
            try await db.collection("eventsTest").document(NSUUID().uuidString).setData([
                "name": withName,
                "theme": theme ,
                "description": description,
                "image": image
            ])
        } catch {
            print("DEBUG: Failed to add Event,  \(error.localizedDescription)")
        }
    }
    
    func updateEvent(withID: String,name: String, theme: String, description: String) async throws {
        do {
            try await db.collection("eventsTest").document(withID).setData([
                "name": name,
                "theme": theme ,
                "description": description,
                "image": "event-party-portada"
            ])
        } catch {
            print("DEBUG: Feiled to update Event, \(error.localizedDescription)")
        }
    }
    
    func fetchHomeEvents() async {
        db.collection("eventsTest").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No events")
                return
            }
            
            self.homeViewEvents = documents.map { (queryDocumentSnapshot) -> Event in
                let data = queryDocumentSnapshot.data()
                
                let id = queryDocumentSnapshot.documentID
                let name = data["name"] as? String ?? ""
                let theme = data["theme"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                
                return Event(id: id, name: name, theme: theme, description: description, image: "event-party-portada")
            }
        }
    }
    
    func deleteEvent(withID: String) {
        db.collection("eventsTest").document(withID).delete() { err in
          if let err = err {
            print("Error removing document: \(err)")
          } else {
            print("Document successfully removed!")
          }
        }
    }
}
