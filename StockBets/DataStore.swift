//
//  DataStore.swift
//  StockBets
//
//  Created by Dean Carpenter on 10/26/17.
//  Copyright © 2017 6thStreetProductions. All rights reserved.
//

import Foundation
import Firebase

class DataStore {
    static let shared = DataStore()
    
    private var ref: DatabaseReference!
    
    private var users: [User]!
    private var posts: [Post]!
    private var bets: [Bet]!
    
    private var currentUser: User?
    
    private init() {
        // Get a database reference.
        ref = Database.database().reference()
    }
    
    func userCount() -> Int {
        return users.count
    }
    
    func postCount() -> Int {
        return posts?.count ?? 0
    }
    
    func betCount() -> Int {
        return bets?.count ?? 0
    }
    
    func getUser(index: Int) -> User {
        return users[index]
    }
    
    func addUser(user: User) {
        // define array of key/value pairs to store for this person.
        let userRecord = [
            "username": user.username,
            "email": user.email
        ]
        
        // Save to Firebase.
        self.ref.child("users").child(user.username).setValue(userRecord)
        
        // Also save to our internal array, to stay in sync with what's in Firebase.
        users.append(user)
    }
    
    func loadUsers() {
        var newUsers = [User]()
        
        // Fetch the data from Firebase and store it in our internal users array.
        // This is a one-time listener.
        ref.child("users").observe(DataEventType.value, with: { (snapshot) in
            // Get the top-level dictionary.
            let value = snapshot.value as? NSDictionary
            
            if let users = value {
                // Iterate over the user objects and store in our internal users array.
                for u in users {
                    let username = u.key as! String
                    let user = u.value as! [String:String]
                    let email = user["email"]
                    let newUser = User(username: username,
                                       email: email!)
                    newUsers.append(newUser)
                }
                self.users = newUsers
            }
            
            print("\(DataStore.shared.userCount()) users have been loaded from firebase!")
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func loadPosts() {
        // Start with an empty array.
        var newPosts = [Post]()
        
        // Fetch the data from Firebase and store it in our internal users array.
        ref.child("posts").observe(DataEventType.value, with: { (snapshot) in
            // Get the top-level dictionary.
            let value = snapshot.value as? NSDictionary
            
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
                    print("Owner: \(ownerUsername): \(date.description)")
                    
                    let newPost = Post(ownerUsername: ownerUsername, date: date, post: postString)
                    newPosts.append(newPost)
                }
                self.posts = newPosts
            }
            
            print("\(DataStore.shared.postCount()) posts have been loaded from firebase!")
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func loadBets() {
        // Start with an empty array.
        var newBets = [Bet]()
        
        // Fetch the data from Firebase and store it in our internal users array.
        ref.child("bets").observe(DataEventType.value, with: { (snapshot) in
            // Get the top-level dictionary.
            let value = snapshot.value as? NSDictionary
            
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
                self.bets = newBets
            }
            
            print("\(DataStore.shared.betCount()) bets have been loaded from firebase!")
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    /*
     Creates a post for the current user. These are shown on the profile screen.
     
     In order to flatten Firebase structure for optimization, Instead of storing
     a users tweets under the "user" key, I store it under a separate "posts" key.
     To maintain a unique key under "posts", I'm going to store the posts from each
     userer as a "username:timestamp" pair. This makes retrieval easy, just search the posts
     for all posts matching "username" in the "username:timestamp" pair.
     */
    func post(postText: String) {
        // this produces a decimal, need to convert to
        let time = NSDate().timeIntervalSince1970
        let timestamp = NSInteger(round(time)).description
        
        if let username = Auth.auth().currentUser?.displayName {
            let timestampAndUsernameKey:String = username + ":" + timestamp
            let postDict = [
                "ownerUsername": username,
                "post": postText,
                "time": timestamp
                ] as [String : Any]
            
            self.ref.child("posts").child(timestampAndUsernameKey).setValue(postDict)
        }
        
        /*
         -- For decoding the timestamp
         let myTimeInterval = TimeInterval(timestamp)
         let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
         -- Then, call the appropriate NSDate() functions
         */
    }
    
    func bet(stock: String, priceTarget: String, weeks: String) {
        let time = NSDate().timeIntervalSince1970
        let timestamp = NSInteger(round(time)).description
        
        if let username = Auth.auth().currentUser?.displayName {
            let timestampAndUsernameKey:String = username + ":" + timestamp
            print(timestampAndUsernameKey)
            let betDict = [
                "stock": stock,
                "priceTarget": priceTarget,
                "weeks": weeks,
                "ownerUsername": username,
                "time": timestamp
                ] as [String : Any]
            
            self.ref.child("bets").child(timestampAndUsernameKey).setValue(betDict)
        }
    }
}
