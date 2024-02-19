//
//  RendezApp.swift
//  Rendez
//
//  Created by Miguel Hernandez on 4/27/23.
//

import SwiftUI
import Firebase

@main
struct RendezApp: App {
    @StateObject var viewModel = AuthViewModel()
    @StateObject var viewModelEvents = EventsViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModelEvents)
                .environmentObject(viewModel)
                .environment(\.colorScheme, .light)
        }
    }
}
