//
//  Tweet.swift
//  StockBets
//
//  Created by He, Kelvin on 10/31/17.
//  Copyright © 2017 6thStreetProductions. All rights reserved.
//

import Foundation

class Tweet {
    
    var username:String
    var timestamp:String
    var message:String
    
    init(username: String, timestamp:String, message:String) {
        self.username = username
        self.timestamp = timestamp
        self.message = message
    }
}
