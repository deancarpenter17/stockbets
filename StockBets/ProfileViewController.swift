//
//  ProfileViewController.swift
//  StockBets
//
//  Created by He, Kelvin on 10/30/17.
//  Copyright © 2017 6thStreetProductions. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var tweets:[Tweet] = []
    private var positions:[String] = []

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    let themeBlue: UIColor = UIColor(red:0.16, green:0.21, blue:0.25, alpha:1.0)
    let themeGreen: UIColor = UIColor(red:0.43, green:0.85, blue:0.63, alpha:1.0)


    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Profile"
        
        createDataModels()
        
        self.navigationController?.navigationBar.barTintColor = themeBlue
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: themeGreen]
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createDataModels() {
        let tweet1 = Tweet.init(username: "StockBets", timestamp: "1 hour ago", message: "$SNAP is way too overvalued.")
        let tweet2 = Tweet.init(username: "StockBets", timestamp: "2 hours ago", message: "@TradeJoe lol you really think the $SNAP IPO will be successful?")
        tweets.append(tweet1)
        tweets.append(tweet2)
        
        let position1 = "$AMD @ 15 on 10/31/17 (CALL)"
        let position2 = "$JDST @ $17 on 10/31/17 (PUT)"
        
        positions.append(position1)
        positions.append(position2)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var returnValue = 0
        
        switch(segmentedControl.selectedSegmentIndex) {
        case 0:
            returnValue = tweets.count
            break
        case 1:
            returnValue = positions.count
            break
        default:
            break
        }
        
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(segmentedControl.selectedSegmentIndex == 0) {
            let tweet = tweets[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
            cell.config(username: tweet.username, timestamp: tweet.timestamp, message: tweet.message)
            return cell
        }
        else {
            let position = positions[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "positionCell", for: indexPath) as! PositionTableViewCell
            cell.positionLabel.text = position
            return cell
        }
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: Any) {
        tableView.reloadData()
    }
    
}
