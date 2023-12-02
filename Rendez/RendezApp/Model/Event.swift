//
//  Event.swift
//  Rendez
//
//  Created by Miguel Hernandez on 5/30/23.
//

import Foundation
import SwiftUI

struct Event {
    var id: String
    var name: String
    var theme: String
    var description: String
    var image: String
}

extension Event {
    static var MOCK_EVENT = Event(id: NSUUID().uuidString, name: "Carrera 5Km", theme: "Deporte", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", image: "event-party-portada")
}
