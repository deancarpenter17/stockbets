//
//  PostViewController.swift
//  StockBets
//
//  Created by Dean Carpenter on 11/18/17.
//  Copyright © 2017 6thStreetProductions. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    let placeholderGray: UIColor = UIColor(red:0.88, green:0.90, blue:0.93, alpha:0.8)
    let themeGreen: UIColor = UIColor(red:0.43, green:0.85, blue:0.63, alpha:1.0)
    let themeBlue: UIColor = UIColor(red:0.16, green:0.21, blue:0.25, alpha:1.0)
    
    @IBOutlet weak var cancelPostButton: UIBarButtonItem!
    @IBOutlet weak var submitPostButton: UIBarButtonItem!
    @IBOutlet weak var postTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated:true);
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.tabBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelPostButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    // updates database to include the post. Sends them back to home screen
    @IBAction func submitPostButton(_ sender: Any) {
        if let post = postTextView.text {
            if post == "" {
                AlertController.showAlert(self, title: "Error", message: "Posts must contain a body!")
                return
            }
            DataStore.shared.post(postText: post)
            postTextView.resignFirstResponder()
            
            // send them to home screen
            guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return }
            let rootController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarController")
            appDel.window?.rootViewController = rootController
            AlertController.showAlert(self, title: "Success!", message: "Posted successfully")
        }
        else {
            AlertController.showAlert(self, title: "Error", message: "Posts must contain a body!")
        }
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
        //postTextView.attributedPlaceholder = NSAttributedString(string:"What would you like to post?:", attributes: [NSForegroundColorAttributeName: placeholderGray])
        
        // enable line breaks inside textview
        postTextView.textContainer.lineBreakMode = NSLineBreakMode(rawValue: 1)!
        postTextView.layer.cornerRadius = 15.0
        postTextView.layer.borderWidth = 1.5
        postTextView.layer.borderColor = themeGreen.cgColor
        postTextView.backgroundColor = themeBlue
        postTextView.layer.sublayerTransform = CATransform3DMakeTranslation(10, 10, 10)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 'First Responder' is the same as 'input focus'.
        // We are removing input focus from the text field.
        textField.resignFirstResponder()
        return true
    }
    
    // Called when the user touches on the main view (outside the UITextField).
    //
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
