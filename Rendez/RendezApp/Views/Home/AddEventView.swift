//
//  AddEventView.swift
//  Rendez
//
//  Created by Miguel Hernandez on 11/30/23.
//

import SwiftUI

struct AddEventView: View {
    @State private var name = ""
    @State private var theme = ""
    @State private var description = ""
    @State var selectedImage: UIImage?
    @State var selectedDate = Date.now
    @State var isPicker = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: EventsViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
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
                
                // Input Stack
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
                        try await viewModel.createEvent(
                            withName: name,
                            theme: theme,
                            description: description,
                            selectedImage: selectedImage ?? UIImage(imageLiteralResourceName: "event-party-portada"), 
                            selectedDate: selectedDate)
                    }
                    dismiss()
                }, label: {
                    HStack {
                        Text("Add Event")
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
            .navigationTitle("Add Event")
            .sheet(isPresented: $isPicker, onDismiss: nil, content: {
                ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPicker)
            })
        }
    }
}

#Preview {
    AddEventView()
}
