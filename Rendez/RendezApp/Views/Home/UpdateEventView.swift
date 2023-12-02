//
//  UpdateEventView.swift
//  Rendez
//
//  Created by Miguel Hernandez on 11/30/23.
//

import SwiftUI

struct UpdateEventView: View {
    @State private var name = ""
    @State private var theme = ""
    @State private var description = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: EventsViewModel
    
    var event: Event
    
    var body: some View {
        VStack {
            VStack {
                inputView(text: $name, title: "Event Name", placeholder: "Example: How to cook")
                inputView(text: $theme, title: "Event Theme", placeholder: "Example: Cooking")
                
                inputView(text: $description, title: "Event Description", placeholder: "Example: In this event you will lear the basics of cooking!")
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            
            
            Button(action: {
                Task {
                    try await viewModel.updateEvent(
                            withID: event.id,
                            name: name,
                            theme: theme,
                            description: description)
                }
                
            }, label: {
                HStack {
                    Text("Update Event")
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
        .navigationTitle("Update Event")
    }
}

struct UpdateEventView_Previews: PreviewProvider {
    static var previews: some View {
        ListDetailView(event: Event(id: "asd", name: "Como cocinar un huevo", theme: "Cocina", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", image: "frying.pan"))
    }
}
