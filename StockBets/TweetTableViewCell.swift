//
//  TweetTableViewCell.swift
//  StockBets
//
//  Created by He, Kelvin on 10/31/17.
//  Copyright © 2017 6thStreetProductions. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func config(username: String, timestamp: String, message: String) {
        messageLabel.text = message
        usernameLabel.text = "@" + username
        timestampLabel.text = String(timestamp)
        
    }
}
