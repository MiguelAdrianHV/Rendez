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
    @State var selectedImage: UIImage?
    @State var selectedDate = Date.now
    @State var isPicker = false
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: EventsViewModel
    
    var event: Event
    
    var body: some View {
        VStack {
            
            // Image selector
            if selectedImage != nil {
                Image(uiImage: selectedImage!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .padding(.vertical, 32)

            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .padding(.vertical, 32)

            }
            Button(action: {
                isPicker = true
            }, label: {
                Text("Select a photo")
            })
            
            VStack {
                inputView(text: $name, title: "Event Name", placeholder: "Example: How to cook")
                
                inputView(text: $theme, title: "Event Theme", placeholder: "Example: Cooking")
                
                inputView(text: $description, title: "Event Description", placeholder: "Example: In this event you will lear the basics of cooking!")
                
                DatePicker("Event date:", selection: $selectedDate, in: Date.now...)
                    .foregroundStyle(Color(.darkGray))
                    .fontWeight(.semibold)
                    .font(.footnote)
                    .padding()
                
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            
            
            Button(action: {
                Task {
                    try await viewModel.updateEvent(
                            withID: event.id,
                            name: name,
                            theme: theme,
                            description: description,
                            selectedDate: dateFormatter.string(from: selectedDate))
                }
                self.presentationMode.wrappedValue.dismiss()
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
        ListDetailView(event: Event(id: "asd", name: "Como cocinar un huevo", theme: "Cocina", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", image: UIImage(imageLiteralResourceName: "event-party-portada"), eventDate: "2020")).environmentObject(EventsViewModel())
    }
}
