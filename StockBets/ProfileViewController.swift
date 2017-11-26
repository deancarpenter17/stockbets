//
//  ProfileViewController.swift
//  StockBets
//
//  Created by Dean Carpenter on 11/21/17.
//  Copyright © 2017 6thStreetProductions. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    private var ref: DatabaseReference!
    
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
        ref = Database.database().reference()
        
        navigationItem.title = "Profile"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadPosts()
        loadBets()

        self.navigationController?.navigationBar.barTintColor = themeBlue
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: themeGreen]
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch(segmentedControl.selectedSegmentIndex) {
        case 0:
            return posts?.count ?? 0
        case 1:
            return bets?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
    
    func loadPosts() {

        // Fetch the data from Firebase and store it in our internal users array.
        ref.child("posts").observe(DataEventType.value, with: { (snapshot) in
            // Get the top-level dictionary.
            let value = snapshot.value as? NSDictionary
            
            var newPosts = [Post]()

            if let posts = value {
                // Iterate over the user objects and store in our internal users array.
                for p in posts {
                    let post = p.value as! [String:String]
                    let ownerUsername = post["ownerUsername"]!
                    let time = post["time"]!
                    let postString = post["post"]!
                    
                    // extract NSDate from timeSince1970 which is stored in db
                    let myTimeInterval = TimeInterval(time)
                    let date = NSDate(timeIntervalSince1970: myTimeInterval!)
                    let newPost = Post(ownerUsername: ownerUsername, date: date, post: postString)
                    newPosts.append(newPost)
                }
                // Sort by date, Descending order
                newPosts = newPosts.sorted(by: { Double($0.date.timeIntervalSinceNow) > Double($1.date.timeIntervalSinceNow) })
                
                self.posts = newPosts
                print("\(self.posts.count) posts have been loaded from firebase!")
                self.tableView.reloadData()
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func loadBets() {
        // Start with an empty array.

        // Fetch the data from Firebase and store it in our internal users array.
        ref.child("bets").observe(DataEventType.value, with: { (snapshot) in
            // Get the top-level dictionary.
            let value = snapshot.value as? NSDictionary
            
            var newBets = [Bet]()
            
            if let bets = value {
                // Iterate over the user objects and store in our internal users array.
                for b in bets {
                    let bet = b.value as! [String: String]
                    let ownerUsername = bet["ownerUsername"]!
                    let time = bet["time"]!
                    // double bang is fine, we validated user input
                    let weeks: Int = Int(bet["weeks"]!)!
                    let priceTarget: Double = Double(bet["priceTarget"]!)!

                    let stock = bet["stock"]!
                    
                    // extract NSDate from timeSince1970 which is stored in db
                    let myTimeInterval = TimeInterval(time)
                    let date = NSDate(timeIntervalSince1970: myTimeInterval!)
                    
                    let newBet = Bet(stock: stock, price: priceTarget, weeks: weeks, ownerUsername: ownerUsername, date: date)
                    newBets.append(newBet)
                }
                newBets = newBets.sorted(by: { Double($0.date.timeIntervalSinceNow) > Double($1.date.timeIntervalSinceNow) })
                self.bets = newBets
                self.tableView.reloadData()
            }
            print("\(self.bets.count) bets have been loaded from firebase!")
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
