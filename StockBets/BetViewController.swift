//
//  BetViewController.swift
//  StockBets
//
//  Created by Dean Carpenter on 11/18/17.
//  Copyright © 2017 6thStreetProductions. All rights reserved.
//

import UIKit

class BetViewController: UIViewController {
    
    let placeholderGray: UIColor = UIColor(red:0.88, green:0.90, blue:0.93, alpha:0.8)
    let themeGreen: UIColor = UIColor(red:0.43, green:0.85, blue:0.63, alpha:1.0)
    let themeBlue: UIColor = UIColor(red:0.16, green:0.21, blue:0.25, alpha:1.0)
    
    @IBOutlet weak var stockTextField: UITextField!
    @IBOutlet weak var priceTargetTextField: UITextField!
    @IBOutlet weak var weeksTextField: UITextField!
    
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
        self.navigationItem.setHidesBackButton(false, animated:animated);
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func cancelBetButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitBetButton(_ sender: Any) {
        if var stock = stockTextField.text,
            let priceText = priceTargetTextField.text,
            let weeksText = weeksTextField.text {
            if stock == "" || priceText == "" || weeksText == "" {
                AlertController.showAlert(self, title: "Error", message: "You must fill out all fields!")
                return
            }
            
            // ticker symbol should be capitalized
            stock = stock.uppercased()
            
            // Validate the price/weeks strings.
            if let _ = Double(priceText),
                let _ = Int(weeksText) {
                
                DataStore.shared.bet(stock: stock, priceTarget: priceText, weeks: weeksText)
                
                // this fixes a bug where the soft keyboard doesn't go away, even though
                // we have the methods defined below..
                stockTextField.resignFirstResponder()
                priceTargetTextField.resignFirstResponder()
                weeksTextField.resignFirstResponder()
                
                // send them to home screen
                guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return }
                let rootController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarController")
                appDel.window?.rootViewController = rootController
                AlertController.showAlert(self, title: "Success!", message: "Bet successfully!")
            }
            
            else {
                AlertController.showAlert(self, title: "Error!", message: "Price target & time frame must be a valid number. Try again.")
                return
            }
        }
        else {
            AlertController.showAlert(self, title: "Error", message: "You must fill out all fields!")
        }
    }
    
    func setupViews() {
        stockTextField.attributedPlaceholder = NSAttributedString(string:"Enter ticker symbol", attributes: [NSForegroundColorAttributeName: placeholderGray])
        stockTextField.layer.cornerRadius = 15.0
        stockTextField.layer.borderWidth = 1.5
        stockTextField.layer.borderColor = themeGreen.cgColor
        stockTextField.backgroundColor = themeBlue
        stockTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        priceTargetTextField.attributedPlaceholder = NSAttributedString(string:"$", attributes: [NSForegroundColorAttributeName: placeholderGray])
        priceTargetTextField.layer.cornerRadius = 15.0
        priceTargetTextField.layer.borderWidth = 1.5
        priceTargetTextField.layer.borderColor = themeGreen.cgColor
        priceTargetTextField.backgroundColor = themeBlue
        priceTargetTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        weeksTextField.attributedPlaceholder = NSAttributedString(string:"Enter # of weeks", attributes: [NSForegroundColorAttributeName: placeholderGray])
        weeksTextField.layer.cornerRadius = 15.0
        weeksTextField.layer.borderWidth = 1.5
        weeksTextField.layer.borderColor = themeGreen.cgColor
        weeksTextField.backgroundColor = themeBlue
        weeksTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
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
