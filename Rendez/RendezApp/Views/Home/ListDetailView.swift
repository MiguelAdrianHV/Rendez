//
//  ListDetailView.swift
//  Rendez
//
//  Created by Miguel Hernandez on 5/30/23.
//

import SwiftUI

struct ListDetailView: View {
    @EnvironmentObject var viewModel: EventsViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var event: Event
    
    var body: some View {
        VStack {
            Image("event-party-portada")
                .resizable()
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 4))
                .shadow(color: Color.gray, radius: 5)
            HStack {
                Text(event.name)
            }
                .font(.title)
            Text("Event id: \(event.id)")
            Text(event.theme)
            
            Text(event.description)
                .padding()
                .multilineTextAlignment(.center)
            
            Button(action: {
                viewModel.deleteEvent(withID: event.id)
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                HStack {
                    Text("Delete Event")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            })
                .background(Color(.systemOrange))
                .cornerRadius(10)
                .padding(.top, 24)
                
                
        }
        .navigationBarItems(trailing:
                                NavigationLink(destination: UpdateEventView(event: event)) {
            Text("Edit")
                .foregroundColor(Color(.systemBlue))
        } )
    }
}

struct ListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ListDetailView(event: Event(id: "asd", name: "Como cocinar un huevo", theme: "Cocina", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", image: "frying.pan"))
    }
}
