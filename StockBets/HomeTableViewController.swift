//
//  HomeTableViewController.swift
//  StockBets
//
//  Created by Edmond Amataj on 10/31/17.
//  Copyright © 2017 6thStreetProductions. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
   

    var stocks = StockList()
    
    let themeBlue: UIColor = UIColor(red:0.16, green:0.21, blue:0.25, alpha:1.0)
    
    override func viewDidLoad() {
        self.navigationItem.setHidesBackButton(true, animated: false)

        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // load stock from firebase, initialize it as a stock and add to stocks array
        initializeStockList()
        
        self.tableView.backgroundColor = themeBlue
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.stocks.size()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stock = stocks.getStock(index: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath) as! HomeTableViewCell
        cell.configStockCell(stock: stock)
        cell.backgroundColor = themeBlue
        return cell
    }
    
    // function that initializes the stock list with data from firebase
    func initializeStockList() {
        let aapl : Stock = Stock(symbol: "AAPL", name: "Apple, Inc", price: "169.04", percentChange: "+2.32", volume: "34,443,055", avgVolume: "28,151,642", dayRange: "166.94-169.65", yearRange: "104.08-169.65", peRatio: "19.21", mktCap: "61.58B", desc: "Apple, Inc. engages in the design, manufacture, and marketing of mobile communication, media devices, personal computers, and portable digital music players.")
        stocks.addStock(stock: aapl)
        let amzn : Stock = Stock(symbol: "AMZN", name: "Amazon.com, Inc", price: "1105.28", percentChange: "-0.50", volume: "3,447,000", avgVolume: "3,442,000", dayRange: "1101.12-1110.54", yearRange: "710.10-1122.79", peRatio: "281.10", mktCap: "531.0B", desc: "Amazon.com, Inc. engages in the provision of online retail shopping services. It operates through the following segments: North America, International, and Amazon Web Services (AWS).")
        stocks.addStock(stock: amzn)
        let baba : Stock = Stock(symbol: "BABA", name: "Alibaba Group", price: "184.89", percentChange: "+1.82", volume: "21,260,000", avgVolume: "18,020,000", dayRange: "181.81-185.12", yearRange: "86.01-185.12", peRatio: "62.40", mktCap: "467.7B", desc: "Alibaba Group Holding Ltd. operates as an online and mobile commerce company. It provides online and mobile marketplaces in retail and wholesale trade, as well as cloud computing and other services.")
        stocks.addStock(stock: baba)
        
        let goog : Stock = Stock(symbol: "GOOG", name: "Google, Inc", price: "1016.64", percentChange: "-0.05", volume: "1,331,000", avgVolume: "1,360,000", dayRange: "1010.42-1024.00", yearRange: "727.54-1048.39", peRatio: "36.84", mktCap: "709.6B", desc: "Alphabet, Inc. is a holding company, which engages in the business of acquisition and operation of different companies. It operates through the Google and Other Bets segments. The Google segment includes its main Internet products such as Search, Ads, Commerce, Maps, etc.")
        stocks.addStock(stock: goog)
        
        let tsla : Stock = Stock(symbol: "TSLA", name: "Tesla, Inc", price: "331.53", percentChange: "+3.58", volume: "5,672,000", avgVolume: "5,759,000", dayRange: "320.18-331.95", yearRange: "178.19-389.61", peRatio: "-", mktCap: "55.33B", desc: "Tesla, Inc. engages in the designing, development, manufacturing and sale of electric vehicles and electric power train components. Its products include electric vehicles such as the Model S, Model X, Model 3 and the Tesla Roadster.")
        stocks.addStock(stock: tsla)
        
        let fb : Stock = Stock(symbol: "FB", name: "Facebook, Inc", price: "180.06", percentChange: "+0.11", volume: "20,170,000", avgVolume: "14,340,000", dayRange: "178.94-180.80", yearRange: "113.55-180.80", peRatio: "40.30", mktCap: "522.9B", desc: "Facebook, Inc. engages in the development of social media applications for people to connect through mobile devices, personal computers, and other surfaces. It enables users to share opinions, ideas, photos, videos, and other activities online.")
        
        stocks.addStock(stock: fb)
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "fundamentalsID" {
            let destination = segue.destination as! FundamentalsViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                let stock = stocks.getStock(index: indexPath.row)
                destination.stock = stock
            } else {
                print("no")
            }
        }
    }
}
