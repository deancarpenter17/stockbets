//
//  LaunchViewController.swift
//  StockBets
//
//  Created by Edmond Amataj on 10/18/17.
//  Copyright © 2017 6thStreetProductions. All rights reserved.
//

import UIKit


class LaunchViewController: UIViewController {

    @IBOutlet weak var backgroundGIF: UIImageView!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let gif = UIImage.gif(name: "background")
        
        backgroundGIF.image = gif
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        signupBtn.backgroundColor = UIColor(red: 0.596, green: 1.0, blue: 0.596, alpha: 1.0)
        signupBtn.layer.borderWidth = 1
        signupBtn.layer.borderColor = UIColor.black.cgColor
        
        loginBtn.backgroundColor = .clear
        loginBtn.layer.borderWidth = 3
        loginBtn.layer.borderColor = UIColor.white.cgColor
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
