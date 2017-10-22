//
//  SearchTableViewController.swift
//  ARShop
//
//  Created by Cameron Moreau on 10/21/17.
//  Copyright © 2017 cameronmoreau. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {

    lazy var searchBar: UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 280, height: 20))
    
    var searchResults = [
        Product(color: "Space Gray", formattedPrice: "$699.99", family: "iPhone 8", rating: 2.3),
        Product(color: "Matte Black", formattedPrice: "$699.99", family: "iPhone 8", rating: 2.3),
        Product(color: "Black", formattedPrice: "$199.99", family: "Nexus 5X", rating: 4.9),
        Product(color: "White", formattedPrice: "$499.99", family: "iPad Mini", rating: 4.3),
        Product(color: "White", formattedPrice: "$299.99", family: "Pixel 2", rating: 3.4),
    ]
    
    @IBAction func btnCancelPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Searchbar
        searchBar.placeholder = "Search products"
        searchBar.searchBarStyle = .minimal
        let leftNavBarButton = UIBarButtonItem(customView: searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as! SearchResultTableViewCell

        // Configure the cell...
        let product = self.searchResults[indexPath.row]
        cell.setup(product: product)

        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
