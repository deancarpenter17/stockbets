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
    private var currentUser: User?
    
    private init() {
        // Get a database reference.
        // Needed before we can read/write to/from the firebase database.
        ref = Database.database().reference()
    }
    
    func count() -> Int {
        return users.count
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
        // Start with an empty array.
        users = [User]()
        
        // Fetch the data from Firebase and store it in our internal people array.
        // This is a one-time listener.
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get the top-level dictionary.
            let value = snapshot.value as? NSDictionary
            
            if let users = value {
                // Iterate over the user objects and store in our internal people array.
                for u in users {
                    let username = u.key as! String
                    let user = u.value as! [String:String]
                    let email = user["email"]
                    let newUser = User(username: username,
                                       email: email!)
                    self.users.append(newUser)
                }
            }
            
            print("\(DataStore.shared.count()) users have been loaded from firebase!")
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
    func post(userPost: String) {
        // this produces a decimal, need to convert to
        let time = NSDate().timeIntervalSince1970
        let timestamp = NSInteger(round(time)).description

        if let username = Auth.auth().currentUser?.displayName {
            let timestampAndUsernameKey:String = username + ":" + timestamp
            print(timestampAndUsernameKey)
            let postDict = ["post": userPost]
            self.ref.child("posts").child(timestampAndUsernameKey).setValue(postDict)
        }
        
        /*
        -- For decoding the timestamp
        let myTimeInterval = TimeInterval(timestamp)
        let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
        -- Then, call the appropriate NSDate() functions
        */
    }
}
