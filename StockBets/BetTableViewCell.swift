//
//  PositionTableViewCell.swift
//  StockBets
//
//  Created by He, Kelvin on 10/31/17.
//  Copyright © 2017 6thStreetProductions. All rights reserved.
//

import UIKit

class BetTableViewCell: UITableViewCell {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var weeksLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    /*
     stock: String, price: Double, weeks: Int, ownerUsername: String, date: NSDate
    */
    func config(username: String, date: NSDate, stock: String, price: Double, weeks: Int) {
        dateLabel.text = DataStore.shared.convertNSDate(date: date)
        stockLabel.text = "$" + stock
        priceLabel.text = "@ $" + String(price)
        weeksLabel.text = "in " + String(weeks) + " weeks"
        usernameLabel.text = "@" + username

    }
}
