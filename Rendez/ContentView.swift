//
//  ContentView.swift
//  Rendez
//
//  Created by Miguel Hernandez on 4/27/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.UserSession != nil {
                MainView()
            } else {
                LoginView()
            }
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
