//
//  AlertController.swift
//  StockBets
//
//  Created by Dean Carpenter on 10/27/17.
//  Copyright © 2017 6thStreetProductions. All rights reserved.
//

import UIKit

class AlertController: UIAlertController {
    static func showAlert(_ inViewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        inViewController.present(alert, animated: true, completion: nil)
    }
}
