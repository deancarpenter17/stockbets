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
    let placeholderGray: UIColor = UIColor(red:0.88, green:0.90, blue:0.93, alpha:0.8)

    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var changeEmailTextField: UITextField!
    @IBOutlet weak var changePasswordTextField: UITextField!
    @IBOutlet weak var updatePasswordButton: UIButton!
    @IBOutlet weak var updateEmailButton: RoundedButton!
    
    var currentHighlight: UITextField!

    
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
    
    func textFieldSelected(_ textfield: UITextField) {
        
        // Change the highlighting of textfield and text color
        currentHighlight.layer.borderColor = placeholderGray.cgColor
        currentHighlight.attributedPlaceholder = NSAttributedString(string: currentHighlight.placeholder!, attributes: [NSForegroundColorAttributeName: placeholderGray])
        
        self.currentHighlight = textfield
        currentHighlight.layer.borderColor = themeGreen.cgColor
        currentHighlight.attributedPlaceholder = NSAttributedString(string: currentHighlight.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.white])
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
    
    @IBAction func updateEmail(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        
        if let newEmail = changeEmailTextField.text {
            firebaseAuth.currentUser?.updateEmail(to: newEmail) { (error) in guard error == nil else {  AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
                return
                }
            }
            AlertController.showAlert(self, title: "Success!", message: "You have successfully changed your email associated with this account.")
        }
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
    @IBAction func updatePassword(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        
        if let newPassword = changePasswordTextField.text {
        
            firebaseAuth.currentUser?.updatePassword(to: newPassword) { (error) in guard error == nil else {
                    AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
                    return
                }
            }
            AlertController.showAlert(self, title: "Success!", message: "Your password has been successfully updated.")
        }
    }
    
    func setupViews() {
        // initalize change email textfield
        changeEmailTextField.addTarget(self, action: #selector(self.textFieldSelected(_:)), for: UIControlEvents.touchDown)
        changeEmailTextField.layer.cornerRadius = 15.0
        changeEmailTextField.layer.borderWidth = 1.5
        changeEmailTextField.layer.borderColor = placeholderGray.cgColor
        changeEmailTextField.attributedPlaceholder = NSAttributedString(string:"New email:", attributes: [NSForegroundColorAttributeName: placeholderGray])
        changeEmailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        self.currentHighlight = changeEmailTextField
        
        // initalize change password textfield
        changePasswordTextField.addTarget(self, action: #selector(self.textFieldSelected(_:)), for: UIControlEvents.touchDown)
        changePasswordTextField.layer.cornerRadius = 15.0
        changePasswordTextField.layer.borderWidth = 1.5
        changePasswordTextField.layer.borderColor = placeholderGray.cgColor
        changePasswordTextField.attributedPlaceholder = NSAttributedString(string:"New password:", attributes: [NSForegroundColorAttributeName: placeholderGray])
        // Add padding to the placeholder text, so it's not hugging the start of the textfield
        changePasswordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        // initialize signout Button
        signOutButton.backgroundColor = themeBlue
        signOutButton.tintColor = themeGreen
        signOutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        
        // initalize update password button
        updatePasswordButton.tintColor = themeGreen
        updatePasswordButton.backgroundColor = themeBlue
        updatePasswordButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)

        // initalize update password button
        updateEmailButton.tintColor = themeGreen
        updateEmailButton.backgroundColor = themeBlue
        updateEmailButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        
        // Initialize nav bar settings
        self.navigationController?.navigationBar.barTintColor = themeBlue
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: themeGreen]
    }
}


