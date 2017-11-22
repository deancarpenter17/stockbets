//
//  StockBoardViewController.swift
//  StockBets
//
//  Created by Edmond Amataj on 11/21/17.
//  Copyright © 2017 6thStreetProductions. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class StockBoardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var stock : Stock?
    var bets: [Bet]!
    
    private var ref: DatabaseReference!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var liveFeedLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var percentLbl: UILabel!
    
    let themeGreen: UIColor = UIColor(red:0.43, green:0.85, blue:0.63, alpha:1.0)
    let themeBlue: UIColor = UIColor(red:0.16, green:0.21, blue:0.25, alpha:1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        ref = Database.database().reference()
        
        loadBets()
        loadData()
        
        self.title = stock?.symbol
        self.liveFeedLbl.backgroundColor = themeBlue
        self.navigationController?.navigationBar.tintColor = themeGreen
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("bet count: \(bets?.count ?? 0)")
        return bets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt indexPath: \(indexPath.row)")
        let bet = bets[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockBoardBetCell", for: indexPath) as! BetsBoardTableViewCell
        cell.config(username: bet.ownerUsername, date: bet.date, stock: bet.stock, price: bet.priceTarget, weeks: bet.weeks)
        return cell
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
    
    func loadBets() {

        // Fetch the data from Firebase and store it in our internal users array.
        ref.child("bets").observe(DataEventType.value, with: { (snapshot) in
            // Get the top-level dictionary.
            let value = snapshot.value as? NSDictionary
            
            var newBets = [Bet]()
            
            if let bets = value {
                // Iterate over the user objects and store in our internal users array.
                for b in bets {
                    let bet = b.value as! [String: String]
                    let ownerUsername = bet["ownerUsername"]!
                    let time = bet["time"]!
                    // double bang is fine, we validated user input
                    let weeks: Int = Int(bet["weeks"]!)!
                    let priceTarget: Double = Double(bet["priceTarget"]!)!
                    
                    let stock = bet["stock"]!
                    
                    // extract NSDate from timeSince1970 which is stored in db
                    let myTimeInterval = TimeInterval(time)
                    let date = NSDate(timeIntervalSince1970: myTimeInterval!)
                    
                    let newBet = Bet(stock: stock, price: priceTarget, weeks: weeks, ownerUsername: ownerUsername, date: date)
                    newBets.append(newBet)
                }
                newBets = newBets.sorted(by: { Double($0.date.timeIntervalSinceNow) > Double($1.date.timeIntervalSinceNow) })
                self.bets = newBets
                self.filterBetsForCurrentStock()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            print("\(self.bets.count) bets have been loaded from firebase!")
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    // we only want to show bets for the stock the user clicked on.
    func filterBetsForCurrentStock() {
        print(self.stock!.symbol)
        bets = bets.filter({$0.stock == self.stock!.symbol})
    }
    
    
    func loadData() {
        nameLbl.text = stock?.name
        priceLbl.text = stock?.price
        percentLbl.text = stock!.percentChange + "%"
    }
    
    

}
