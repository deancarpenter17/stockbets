//
//  BetPostViewController.swift
//  StockBets
//
//  Created by Dean Carpenter on 11/18/17.
//  Copyright © 2017 6thStreetProductions. All rights reserved.
//

import UIKit

class BetPostViewController: UIViewController {

    let themeGreen: UIColor = UIColor(red:0.43, green:0.85, blue:0.63, alpha:1.0)
    let themeBlue: UIColor = UIColor(red:0.16, green:0.21, blue:0.25, alpha:1.0)
    
    @IBOutlet weak var betButton: UILabel!
    @IBOutlet weak var postButton: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated:true);
        self.tabBarController?.tabBar.isHidden = true
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
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated:true);
        self.tabBarController?.tabBar.isHidden = false
        
    }
    @IBAction func cancelPostBetButton(_ sender: Any) {
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return }
        let rootController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarController")
        appDel.window?.rootViewController = rootController
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setupViews() {
        navigationController?.navigationBar.barTintColor = themeBlue

    }
    
}
