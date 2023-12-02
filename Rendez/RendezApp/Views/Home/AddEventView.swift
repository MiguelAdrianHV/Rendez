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
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: EventsViewModel
    
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
                    try await viewModel.createEvent(withName: name, theme: theme, description: description, image: "event-party-portada")
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
    }
}

#Preview {
    AddEventView()
}
