//
//  SignupViewController.swift
//  StockBets
//
//  Created by Dean Carpenter on 10/26/17.
//  Copyright © 2017 6thStreetProductions. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignupViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signupButton: RoundedButton!
    
    // our defined colors
    let themeGreen: UIColor = UIColor(red:0.43, green:0.85, blue:0.63, alpha:1.0)
    let themeBlue: UIColor = UIColor(red:0.16, green:0.21, blue:0.25, alpha:1.0)
    let placeholderGray: UIColor = UIColor(red:0.88, green:0.90, blue:0.93, alpha:0.8)
    
    // used to dynamically highlight the currently selected textfield with green
    var currentHighlight: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = themeGreen
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
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
    
    @IBAction func signupButton(_ sender: Any) {
        if let username = usernameTextField.text, let password = passwordTextField.text,
            let email = emailTextField.text {
            
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                guard error == nil else {
                    AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
                    print("Could not create user: " + error!.localizedDescription)
                    return
                }
                
                guard let user = user else { return }
                
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = username
                changeRequest.commitChanges(completion: {( error ) in
                    guard error == nil else {
                        AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
                        print("error in commit changes!")
                        return
                    }
                    
                    AlertController.showAlert(self, title: "Success", message: "Successfully signed up!")
                    // self.performSegue(withIdentifier: "signupSegue", sender: nil)
                })
            })
        }
        
        else {
            AlertController.showAlert(self, title: "Missing info", message: "You must fill out all fields!")
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
    
    func textFieldSelected(_ textfield: UITextField) {
        
        // Change the highlighting of textfield and text color
        currentHighlight.layer.borderColor = placeholderGray.cgColor
        currentHighlight.attributedPlaceholder = NSAttributedString(string: currentHighlight.placeholder!, attributes: [NSForegroundColorAttributeName: placeholderGray])
        
        self.currentHighlight = textfield
        currentHighlight.layer.borderColor = themeGreen.cgColor
        currentHighlight.attributedPlaceholder = NSAttributedString(string: currentHighlight.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.white])
    }
    
    func setupViews() {
        // initialize Username textfield
        usernameTextField.addTarget(self, action: #selector(self.textFieldSelected(_:)), for: UIControlEvents.touchDown)
        usernameTextField.layer.cornerRadius = 15.0
        usernameTextField.layer.borderWidth = 1.5
        usernameTextField.layer.borderColor = placeholderGray.cgColor
        usernameTextField.attributedPlaceholder = NSAttributedString(string:"Username:", attributes: [NSForegroundColorAttributeName: placeholderGray])
        // Add padding to the placeholder text, so it's not hugging the start of the textfield
        usernameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        self.currentHighlight = emailTextField
        
        // initialize Password textfield
        passwordTextField.addTarget(self, action: #selector(self.textFieldSelected(_:)), for: UIControlEvents.touchDown)
        passwordTextField.layer.cornerRadius = 15.0
        passwordTextField.layer.borderWidth = 1.5
        passwordTextField.layer.borderColor = placeholderGray.cgColor
        passwordTextField.attributedPlaceholder = NSAttributedString(string:"Password:", attributes: [NSForegroundColorAttributeName: placeholderGray])
        // Add padding to the placeholder text, so it's not hugging the start of the textfield
        passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        // initialize email textfield
        emailTextField.addTarget(self, action: #selector(self.textFieldSelected(_:)), for: UIControlEvents.touchDown)
        emailTextField.layer.cornerRadius = 15.0
        emailTextField.layer.borderWidth = 1.5
        emailTextField.layer.borderColor = placeholderGray.cgColor
        emailTextField.attributedPlaceholder = NSAttributedString(string:"Email:", attributes: [NSForegroundColorAttributeName: placeholderGray])
        // Add padding to the placeholder text, so it's not hugging the start of the textfield
        emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        // initialize Signup Button
        signupButton.backgroundColor = themeGreen
        signupButton.backgroundColor = themeGreen
        signupButton.tintColor = UIColor.white
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
