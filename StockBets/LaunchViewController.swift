//
//  LaunchViewController.swift
//  StockBets
//
//  Created by Edmond Amataj on 10/18/17.
//  Copyright © 2017 6thStreetProductions. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LaunchViewController: UIViewController {

    @IBOutlet weak var backgroundGIF: UIImageView!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    let themeGreen: UIColor = UIColor(red:0.43, green:0.85, blue:0.63, alpha:1.0)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        let gif = UIImage.gif(name: "background")
        backgroundGIF.image = gif
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if Auth.auth().currentUser != nil {
            // TODO: need to skip the launch screen if user is already signed in. Go straight to home
            print("Current user: " + (Auth.auth().currentUser?.displayName)!)
        }
        
        signupBtn.backgroundColor = .clear
        signupBtn.layer.borderWidth = 3
        signupBtn.layer.borderColor = UIColor.white.cgColor
        signupBtn.layer.borderColor = themeGreen.cgColor
        
        loginBtn.backgroundColor = .clear
        loginBtn.layer.borderWidth = 3
        loginBtn.layer.borderColor = UIColor.white.cgColor
        loginBtn.layer.borderColor = themeGreen.cgColor
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
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

}
