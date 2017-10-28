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
            "firstName": user.firstName,
            "lastName": user.lastName,
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
                    let firstName = user["firstName"]
                    let lastName = user["lastName"]
                    let email = user["email"]
                    let newUser = User(firstName: firstName!, lastName: lastName!, username: username,
                                       email: email!)
                    self.users.append(newUser)
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
