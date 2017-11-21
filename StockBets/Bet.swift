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
    var priceTarget: NSNumber
    var weeks: NSNumber
    
    init(stock: String, price: NSNumber, weeks: NSNumber) {
        self.stock = stock
        self.priceTarget = price
        self.weeks = weeks
    }
}
