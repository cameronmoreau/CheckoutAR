//
//  CheckoutTableViewController.swift
//  ARShop
//
//  Created by Cameron Moreau on 10/22/17.
//  Copyright © 2017 cameronmoreau. All rights reserved.
//

import UIKit

class CheckoutTableViewController: UITableViewController, PlacesDelegate {
    
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    var cart = (UIApplication.shared.delegate as! AppDelegate).cart
    var cartDelegate: CartDelegate?
    let api = Api()
    var total: String?
    
    var place = (UIApplication.shared.delegate as! AppDelegate).tmobileStores[0]

    
    @IBAction func cancelBtnPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func btnCheckoutPressed(_ sender: UIButton) {
//        self.dismiss(animated: true, completion: nil)
        UIView.animate(withDuration: 0.6) {
            self.checkoutButton.alpha = 0.2
            
            let coord = self.place.location?.coordinate
            self.api.checkoutOrder(price: self.total!, latittude: coord!.latitude, longitude: coord!.longitude, completion: {
                (UIApplication.shared.delegate as! AppDelegate).cart.removeAll()
                self.cartDelegate?.cartUpdated()
                
                UIView.animate(withDuration: 0.6) {
                    self.checkoutButton.alpha = 1
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        var subTotal: Double = 0.0
        // reduce in swift syntax so weird :-s
        for item in cart {
            subTotal += item.toPriceNumber()
        }
        let tax = subTotal * 0.0825
        subTotalLabel.text = "Sub-Total: \(formatter.string(from: subTotal as NSNumber)!)"
        taxLabel.text = "Tax: \(formatter.string(from: tax as NSNumber)!)"
        self.total = formatter.string(from: (subTotal + tax) as NSNumber)
        totalLabel.text = "Total: \(self.total!)"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 1 {
            return 1
        }
        return cart.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 {
            self.performSegue(withIdentifier: "pickStoreSegue", sender: nil)
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
            cell.textLabel!.text = place.address!
            cell.detailTextLabel!.text = String.init(format: "%.1f miles away", place.dist!/1609.344)
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "checkoutItemCell", for: indexPath) as! CheckoutItemTableViewCell

        // Configure the cell...
        let product = (UIApplication.shared.delegate as! AppDelegate).cart[indexPath.row]
        cell.setup(product: product)

        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Cart Items"
        }
        return "Store Pickup Location"
    }
    
    func placePicked(place: Place) {
        self.place = place
        self.tableView.reloadData()
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
        if segue.identifier == "pickStoreSegue" {
            let vc = segue.destination as! PlacesTableViewController
            vc.delegate = self
        }
    }

}
