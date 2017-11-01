//
//  HomeTableViewCell.swift
//  StockBets
//
//  Created by Edmond Amataj on 10/31/17.
//  Copyright © 2017 6thStreetProductions. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var symbolLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var percentLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configStockCell(stock : Stock) {
        self.symbolLbl.text = stock.symbol
        self.nameLbl.text = stock.name
        self.priceLbl.text = stock.price
        self.percentLbl.text = stock.percentChange
    }

}
