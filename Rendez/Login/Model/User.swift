//
//  User.swift
//  Rendez
//
//  Created by Miguel Hernandez on 11/28/23.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullName: String
    let email: String
    
    var initials: String {
        let formater = PersonNameComponentsFormatter()
        if let components = formater.personNameComponents(from: fullName) {
            formater.style = .abbreviated
            return formater.string(from: components)
        }
        
        return ""
    }
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullName: "Kobe Bryant", email: "name@example.com")
}
