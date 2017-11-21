//
//  ProfileViewController.swift
//  StockBets
//
//  Created by He, Kelvin on 10/30/17.
//  Copyright © 2017 6thStreetProductions. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var posts: [Post]!
    var bets: [Bet]!
    
    let themeBlue: UIColor = UIColor(red:0.16, green:0.21, blue:0.25, alpha:1.0)
    let themeGreen: UIColor = UIColor(red:0.43, green:0.85, blue:0.63, alpha:1.0)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Profile"

        self.navigationController?.navigationBar.barTintColor = themeBlue
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: themeGreen]
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var returnValue = 0
        
        switch(segmentedControl.selectedSegmentIndex) {
        case 0:
            returnValue = DataStore.shared.postCount()
            break
        case 1:
            returnValue = DataStore.shared.betCount()
            break
        default:
            break
        }
        
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        posts = DataStore.shared.getPosts()
        bets = DataStore.shared.getBets()
        usernameLabel.text = "@" + (Auth.auth().currentUser?.displayName)!

        if(segmentedControl.selectedSegmentIndex == 0) {
            let post = posts[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
            cell.config(username: post.ownerUsername, date: post.date, post: post.post)
            return cell
        }
        else {
            let bet = bets[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "betCell", for: indexPath) as! BetTableViewCell
            cell.config(username: bet.ownerUsername, date: bet.date, stock: bet.stock, price: bet.priceTarget, weeks: bet.weeks)
            return cell
        }
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: Any) {
        tableView.reloadData()
    }
    
    /*
        Gonna try to use this to reload the tableview anytime firebase is updated.
    */
    func refreshTable(notification: NSNotification) {
        
        print("Received refreshTable notification!")
        posts = DataStore.shared.getPosts()
        bets = DataStore.shared.getBets()
        self.tableView.reloadData()
    }
}
