//
//  ListDetailView.swift
//  Rendez
//
//  Created by Miguel Hernandez on 5/30/23.
//

import SwiftUI

struct ListDetailView: View {
    @EnvironmentObject var viewModel: EventsViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var event: Event
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                VStack {
                    Image(uiImage: event.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    
                    VStack (alignment: .leading){
                        HStack {
                            Text(viewModel.currentEvent?.name ?? "Title")
                            Spacer()
                        }
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                        
                        Text("Theme of the event:")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.vertical, 8)
                        Text(viewModel.currentEvent?.theme ?? "Theme")
                        
                        Text("Description")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.vertical, 8)
                        Text(viewModel.currentEvent?.description ?? "Description")
                            .lineSpacing(8)
                        
                        Text("Date")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.vertical, 8)
                        Text(viewModel.currentEvent?.eventDate ?? dateFormatter.string(from: Date()))
                            
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30)
                    .offset(y: -40)
                }
                
                
                Spacer()
                
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
                
                
            }
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            viewModel.fetchEventById(withId: event.id)
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.backward")
                .padding(.all, 12)
                .background(Color.white.opacity(0.75))
                .cornerRadius(8)
                .foregroundColor(Color.black)
        }),
                            trailing:
                                NavigationLink(destination: UpdateEventView(event: event)) {
            Image(systemName: "pencil")
                .padding(.all, 12)
                .background(Color.white.opacity(0.75))
                .cornerRadius(8)
                .foregroundColor(Color.black)
        }
        )
    }
}

struct ListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ListDetailView(event:  Event(id: "1", name: "Powder Party", theme: "Party", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", image: UIImage( imageLiteralResourceName: "event-party-portada"), eventDate: dateFormatter.string(from: Date.now))).environmentObject(EventsViewModel())
    }
}
