//
//  SearchView.swift
//  Rendez
//
//  Created by Miguel Hernandez on 5/31/23.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @EnvironmentObject var viewModel: EventsViewModel
    
    var filteredItems: [Event]? {
            if searchText.isEmpty {
                return viewModel.homeViewEvents
            } else {
                return viewModel.homeViewEvents?.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            }
        }
    
    var body: some View {
        VStack{
            NavigationStack {
                TextField("Search", text: $searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
    
                VStack {
                    if let events =  filteredItems {
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
                    Spacer()
                    
                }
                .navigationBarTitle(Text("Search"))
            }
        }
        .background(Color(.systemGroupedBackground))
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView().environmentObject(EventsViewModel())
    }
}
