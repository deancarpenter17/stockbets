//
//  Bet.swift
//  StockBets
//
//  Created by Dean Carpenter on 11/20/17.
//  Copyright © 2017 6thStreetProductions. All rights reserved.
//

import Foundation

class Bet {
    var stock: String
    var priceTarget: Double
    var weeks: Int
    var ownerUsername: String
    var date: NSDate
    var reasoning : String = ""
    
    init(stock: String, price: Double, weeks: Int, ownerUsername: String, date: NSDate) {
        self.stock = stock
        self.priceTarget = price
        self.weeks = weeks
        self.ownerUsername = ownerUsername
        self.date = date
    }
    
    convenience init(stock: String, price: Double, weeks: Int, reasoning : String, ownerUsername: String, date: NSDate) {
        self.init(stock : stock, price : price, weeks : weeks, ownerUsername : ownerUsername, date : date)
        self.reasoning = reasoning
    }
    
}
