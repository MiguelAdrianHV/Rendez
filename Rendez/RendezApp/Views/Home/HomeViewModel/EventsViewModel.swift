//
//  EventsViewModel.swift
//  Rendez
//
//  Created by Miguel Hernandez on 11/29/23.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseStorage

@MainActor
class EventsViewModel: ObservableObject {
    @Published var homeViewEvents: [Event]?
    @Published var currentEvent: Event?
    @Published var currentImage: UIImage?
    @Published var searchResult: [Event]?
    
    private let db = Firestore.firestore()
    init() {
        Task {
            await fetchHomeEvents()
        }
    }
    
    // MARK: - CREATE
    func createEvent(withName: String, theme: String, description: String, selectedImage: UIImage?, selectedDate: Date) async throws{
        do {
            // Stablish reference for Firebase Storage
            let storage = Storage.storage()
            let storageRef = storage.reference()
            
            // Create image data
            let imgData = selectedImage!.jpegData(compressionQuality: 0.8)
            
            //Validate imgData is not nil
            guard imgData != nil else {
                return
            }
            
            // Create path to the event images
            let path = "images/\(NSUUID().uuidString).jpg"
            let eventImagesRef = storageRef.child(path)
            
            // Upload imagedata
            let uploadTask = eventImagesRef.putData(imgData!, metadata: nil) {
                metadata, error in
                
                // Check for errors
                if error == nil && metadata != nil {
                    // Upload register for the event
                    
                    self.db.collection("eventsTest").document(NSUUID().uuidString).setData([
                        "name": withName,
                        "theme": theme ,
                        "description": description,
                        "image": path,
                        "date": dateFormatter.string(from: selectedDate)
                    ])
                    
                }
            }
        } catch {
            print("DEBUG: Failed to add Event,  \(error.localizedDescription)")
        }
    }
    
    // MARK: - READ
    func fetchHomeEvents() async {
        db.collection("eventsTest").addSnapshotListener { [weak self] (querySnapshot, error) in
            guard let self = self else { return }
            guard let documents = querySnapshot?.documents else {
                print("No events")
                return
            }
            
            var imageDictionary: [String: UIImage] = [:]
            let group = DispatchGroup()
            
            for queryDocumentSnapshot in documents {
                group.enter()
                
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let name = data["name"] as? String ?? ""
                let theme = data["theme"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let date = data["date"] as? String ?? ""
                let path = data["image"] as? String
                
                let storeRef = Storage.storage().reference()
                let fileRef = storeRef.child(path!)
                
                fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                    defer { group.leave() }
                    
                    if let error = error {
                        print("Error fetching image for \(id): \(error.localizedDescription)")
                        return
                    }
                    
                    if let data = data, let image = UIImage(data: data) {
                        imageDictionary[id] = image
                    }
                }
            }
            
            group.notify(queue: .main) {
                self.homeViewEvents = documents.map { queryDocumentSnapshot in
                    let id = queryDocumentSnapshot.documentID
                    let name = queryDocumentSnapshot["name"] as? String ?? ""
                    let theme = queryDocumentSnapshot["theme"] as? String ?? ""
                    let description = queryDocumentSnapshot["description"] as? String ?? ""
                    let date = queryDocumentSnapshot["date"] as? String ?? ""
                    let image = imageDictionary[id] ?? UIImage(imageLiteralResourceName: "event-party-portada")
                    
                    return Event(id: id, name: name, theme: theme, description: description, image: image, eventDate: date)
                }
            }
        }
    }

    
    func fetchEventById(withId: String) {
        db.collection("eventsTest").document(withId).getDocument { [weak self] (document, error) in
                    guard let self = self else { return }

                    if let error = error {
                        print("Error getting document: \(error)")
                    } else {
                        if let document = document, document.exists {
                            let data = document.data()
                            let id = document.documentID
                            
                            // Retrive image
                            let path = data?["path"] as? String ?? ""
                            let storageRef = Storage.storage().reference()
                            var image: UIImage? = UIImage(systemName: "person.circle.fill")
                            let imageRef = storageRef.child(path)
                            imageRef.getData(maxSize: 5 * 1024 * 1024) {
                                data, error in
                                
                                if error == nil && data != nil{
                                    if let imageRecived = UIImage(data: data!) {
                                        DispatchQueue.main.async {
                                            image = imageRecived
                                        }
                                    }
                                }
                            }
                            
                            let name = data?["name"] as? String ?? ""
                            let theme = data?["theme"] as? String ?? ""
                            let description = data?["description"] as? String ?? ""
                            let date = data?["date"] as? String ?? ""

                            self.currentEvent = Event(id: id, name: name, theme: theme, description: description, image: image!, eventDate: date)
                        } else {
                            print("Document does not exist")
                        }
                    }
                }
    }
    
    // MARK: - UPDATE
    func updateEvent(withID: String,name: String, theme: String, description: String, selectedDate: String) async throws {
        do {
            try await db.collection("eventsTest").document(withID).setData([
                "name": name,
                "theme": theme ,
                "description": description,
                "image": "event-party-portada",
                "date": selectedDate
            ])
        } catch {
            print("DEBUG: Feiled to update Event, \(error.localizedDescription)")
        }
    }
    
    // MARK: - DELETE
    
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
