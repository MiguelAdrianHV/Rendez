//
//  MainView.swift
//  Rendez
//
//  Created by Miguel Hernandez on 5/30/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem() {
                    Image(systemName: "house")
                    Text("Home")
                }
            SearchView()
                .tabItem() {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            NotificationView()
                .tabItem() {
                    Image(systemName: "bell")
                    Text("Notifications")
                }
            UserView()
                .tabItem() {
                    Image(systemName: "person")
                    Text("User")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
