//
//  StockList.swift
//  StockBets
//
//  Created by Edmond Amataj on 10/31/17.
//  Copyright © 2017 6thStreetProductions. All rights reserved.
//

import Foundation

class StockList {
    
    private var stocks = [Stock]()
    
    func size() -> Int {
        return stocks.count
    }
    
    func addStock(stock : Stock) {
        stocks.append(stock)
    }
    
    func getStock(index : Int) -> Stock {
        guard index < size() else { return Stock() }
        return stocks[index]
    }
    
}
