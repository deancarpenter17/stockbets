//
//  Stock.swift
//  StockBets
//
//  Created by Edmond Amataj on 10/31/17.
//  Copyright © 2017 6thStreetProductions. All rights reserved.
//

import Foundation

class Stock {
    
    var symbol : String = ""
    var name : String = ""
    var price : String = ""
    var percentChange : String = ""
    var volume : String = ""
    var avgVolume : String = ""
    var dayRange : String = ""
    var yearRange : String = ""
    var peRatio : String = ""
    var mktCap : String = ""
    var desc : String = ""
    
    
    init(symbol : String, name : String, price : String, percentChange : String) {
        self.symbol = symbol
        self.name = name
        self.price = price
        self.percentChange = percentChange
    }
    
    init() {}
    
    // another init for more stuff
    init(symbol : String, name : String, price : String, percentChange : String, volume : String, avgVolume : String,
         dayRange : String, yearRange : String, peRatio : String, mktCap : String, desc : String) {
        self.symbol = symbol
        self.name = name
        self.price = price
        self.percentChange = percentChange
        self.volume = volume
        self.avgVolume = avgVolume
        self.dayRange = dayRange
        self.yearRange = yearRange
        self.peRatio = peRatio
        self.mktCap = mktCap
        self.desc = desc
    }
}
