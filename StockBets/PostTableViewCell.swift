//
//  TweetTableViewCell.swift
//  StockBets
//
//  Created by He, Kelvin on 10/31/17.
//  Copyright © 2017 6thStreetProductions. All rights reserved.
//

import UIKit

//cell.config(username: post.ownerUsername, date: post.date, post: post.post)

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func config(username: String, date: NSDate, post: String) {
        dateLabel.text = DataStore.shared.convertNSDate(date: date)
        postLabel.text = post
        usernameLabel.text = "@" + DataStore.shared.getCurrentUsername()
        
    }
}
