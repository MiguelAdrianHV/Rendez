//
//  DateFormatter.swift
//  Rendez
//
//  Created by Miguel Hernandez on 2/14/24.
//

import Foundation
let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .long
        return formatter
    }()
