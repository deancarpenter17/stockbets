//
//  Post.swift
//  StockBets
//
//  Created by Dean Carpenter on 11/20/17.
//  Copyright © 2017 6thStreetProductions. All rights reserved.
//

import Foundation

class Post {
    var ownerUsername: String
    var date: NSDate
    var post: String
    
    init(ownerUsername: String, date: NSDate, post: String) {
        self.ownerUsername = ownerUsername
        self.date = date
        self.post = post
    }
}
