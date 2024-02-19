//
//  ListView.swift
//  Rendez
//
//  Created by Miguel Hernandez on 5/30/23.
//

import SwiftUI



struct ListView: View {
    @EnvironmentObject var viewModel: EventsViewModel
    
    
    var body: some View {
        
        VStack{
            NavigationStack {
                VStack {
                    if let events =  viewModel.homeViewEvents {
                        if !events.isEmpty {
                            ScrollView(.vertical, showsIndicators: false) {
                                VStack {
                                    ForEach(events, id: \.name) { event in
                                        NavigationLink(destination: ListDetailView(event: event)){
                                            RowView(event: event)
                                        }
                                        .shadow(radius: 3)
                                        .padding()
                                    }
                                }
                            }
                        } else {
                            Text("No events available")
                        }
                    }
                    
                }
                .navigationBarTitle(Text("Events"))
                .navigationBarItems(trailing:
                                        NavigationLink(destination: AddEventView()) {
                    Image(systemName: "plus")
                        .resizable()
                        .padding(6)
                        .frame(width: 24, height: 24)
                        .background(Color.blue)
                        .clipShape(Circle())
                        .foregroundColor(.white)
                } )
            }
        }
        .background(Color(.systemGroupedBackground))
        
    }
    
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView().environmentObject(EventsViewModel())
    }
}
