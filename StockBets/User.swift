//
//  User.swift
//  StockBets
//
//  Created by Dean Carpenter on 10/26/17.
//  Copyright © 2017 6thStreetProductions. All rights reserved.
//

import Foundation

class User {
    
    var firstName: String
    var lastName: String
    var username: String
    var email: String
    
    init(firstName: String, lastName: String, username: String, email: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.email = email
    }
}
