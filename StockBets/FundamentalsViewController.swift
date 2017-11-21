//
//  FundamentalsViewController.swift
//  StockBets
//
//  Created by Amataj, Edmond on 10/30/17.
//  Copyright © 2017 6thStreetProductions. All rights reserved.
//

import UIKit

class FundamentalsViewController: UIViewController {
    
    let themeGreen: UIColor = UIColor(red:0.43, green:0.85, blue:0.63, alpha:1.0)
    let themeBlue: UIColor = UIColor(red:0.16, green:0.21, blue:0.25, alpha:1.0)
    
    @IBOutlet weak var closePrice: UILabel!
    @IBOutlet weak var volume: UILabel!
    @IBOutlet weak var avgVolume: UILabel!
    @IBOutlet weak var dayRange: UILabel!
    @IBOutlet weak var yearRange: UILabel!
    @IBOutlet weak var peRatio: UILabel!
    @IBOutlet weak var mktCap: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    
    var stock : Stock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cornerBorder(label: closePrice)
        cornerBorder(label: volume)
        cornerBorder(label: avgVolume)
        cornerBorder(label: dayRange)
        cornerBorder(label: yearRange)
        cornerBorder(label: peRatio)
        cornerBorder(label: mktCap)
        self.navigationController?.navigationBar.tintColor = themeGreen
        initiateLabels()
    }
    
    func cornerBorder(label : UILabel) {
        label.layer.masksToBounds = true
        label.layer.borderColor = themeBlue.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 8
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func initiateLabels() {
        closePrice.text = stock?.price
        volume.text = stock?.volume
        avgVolume.text = stock?.avgVolume
        dayRange.text = stock?.dayRange
        yearRange.text = stock?.yearRange
        peRatio.text = stock?.peRatio
        mktCap.text = stock?.mktCap
        desc.text = stock?.desc
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
