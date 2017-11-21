//
//  StockBoardViewController.swift
//  StockBets
//
//  Created by Edmond Amataj on 11/21/17.
//  Copyright © 2017 6thStreetProductions. All rights reserved.
//

import UIKit

class StockBoardViewController: UIViewController {

    var stock : Stock?

    @IBOutlet weak var liveFeedLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var percentLbl: UILabel!
    
    let themeGreen: UIColor = UIColor(red:0.43, green:0.85, blue:0.63, alpha:1.0)
    let themeBlue: UIColor = UIColor(red:0.16, green:0.21, blue:0.25, alpha:1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = stock?.symbol
        self.liveFeedLbl.backgroundColor = themeBlue
        self.navigationController?.navigationBar.tintColor = themeGreen
        loadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        nameLbl.text = stock?.name
        priceLbl.text = stock?.price
        percentLbl.text = stock!.percentChange + "%"
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "fundamentalsID" {
            let destination = segue.destination as! FundamentalsViewController
            destination.stock = stock
        }
    }
    

}
