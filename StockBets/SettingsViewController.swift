//
//  SettingsViewController.swift
//  StockBets
//
//  Created by Dean Carpenter on 11/16/17.
//  Copyright © 2017 6thStreetProductions. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SettingsViewController: UIViewController {
    
    let themeGreen: UIColor = UIColor(red:0.43, green:0.85, blue:0.63, alpha:1.0)
    let themeBlue: UIColor = UIColor(red:0.16, green:0.21, blue:0.25, alpha:1.0)
    
    @IBOutlet weak var signOutButton: RoundedButton!
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func signOutUser(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("successfully logged out")
            guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return }
            let rootController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LaunchNavigation")
            appDel.window?.rootViewController = rootController
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func setupViews() {
        // initialize Login Button
        signOutButton.backgroundColor = themeBlue
        signOutButton.tintColor = themeGreen
        signOutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        
        // Initialize nav bar settings
        self.navigationController?.navigationBar.barTintColor = themeBlue
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: themeGreen]
    }
}
