//
//  HomeTableViewController.swift
//  StockBets
//
//  Created by Edmond Amataj on 10/31/17.
//  Copyright © 2017 6thStreetProductions. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class HomeTableViewController: UITableViewController {
    
    var stocks = StockList()
    private var currentUser: User?
    
    let themeBlue: UIColor = UIColor(red:0.16, green:0.21, blue:0.25, alpha:1.0)
    let themeGreen: UIColor = UIColor(red:0.43, green:0.85, blue:0.63, alpha:1.0)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize the list of users, posts, and bets from Firebase
        DataStore.shared.loadUsers()
        DataStore.shared.loadPosts()
        DataStore.shared.loadBets()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // load stock from firebase, initialize it as a stock and add to stocks array
        initializeStockList()
        
        self.tableView.backgroundColor = UIColor.white
        
        self.navigationController?.navigationBar.barTintColor = themeBlue
        
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: themeGreen]
        
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
        cell.backgroundColor = UIColor.white
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
        
        let nflx : Stock = Stock(symbol: "NFLX", name: "Netflix, Inc", price: "196.43", percentChange: "-0.98", volume: "5,519,000", avgVolume: "7,024,000", dayRange: "195.22-198.59", yearRange: "110.68-204.38", peRatio: "196.23", mktCap: "85.00B", desc: "Netflix, Inc. operates as an Internet subscription service company, which provides subscription service streaming movies and TV episodes over the Internet and sending DVDs by mail.")
        stocks.addStock(stock: nflx)
        
        let xom : Stock = Stock(symbol: "XOM", name: "Exxon", price: "83.35", percentChange: "-0.23", volume: "9,754,000", avgVolume: "9,410,000", dayRange: "83.17-83.68", yearRange: "76.05-93.22", peRatio: "30.05", mktCap: "353.2B", desc: "Exxon Mobil Corp. engages in the exploration, development, and distribution of oil, gas, and petroleum products. It operates through the following segments: Upstream, Downstream, and Chemical.")
        stocks.addStock(stock: xom)
        
        let jpm : Stock = Stock(symbol: "JPM", name: "JPMorgan Chase & Co", price: "100.61", percentChange: "-0.79", volume: "8,690,000", avgVolume: "11,740,000", dayRange: "100.57-101.70", yearRange: "67.64-102.42", peRatio: "14.50", mktCap: "349.0B", desc: "JPMorgan Chase &amp; Co. is a financial holding company, which provides financial and investment banking services.")
        stocks.addStock(stock: jpm)
        
        let msft : Stock = Stock(symbol: "MSFT", name: "Microsoft", price: "83.18", percentChange: "-0.85", volume: "27,090,000", avgVolume: "19,540,000", dayRange: "83.11-84.36", yearRange: "57.28-86.20", peRatio: "30.69", mktCap: "641.8B", desc: "Microsoft Corp. engages in the provision of developing and marketing software and hardware services. Its products include operating systems for computing devices, servers, phones and intelligent devices.")
        stocks.addStock(stock: msft)
        
        
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
        
        if segue.identifier == "stockBoardID" {
            let destination = segue.destination as! StockBoardViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                let stock = stocks.getStock(index: indexPath.row)
                destination.stock = stock
            }
        }
    }
}
