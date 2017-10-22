/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Empty application delegate class.
*/

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
    let api = Api()
    var searchResults = [Product]()
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        
        // Load products
        api.getProducts { products in
            if let products = products {
                self.searchResults = products
            }
        }
    }
    
//    var searchResults = [
//        Product(color: "Space Gray s3", formattedPrice: "$699.99", family: "iPhone 8", rating: 2.3, modelKey: "galaxys3"),
//        Product(color: "Matte Black vas", formattedPrice: "$699.99", family: "iPhone 8", rating: 2.3, modelKey: "vase"),
//        Product(color: "Black cup", formattedPrice: "$199.99", family: "Nexus 5X", rating: 4.9, modelKey: "cup"),
//        Product(color: "White s3", formattedPrice: "$499.99", family: "iPad Mini", rating: 4.3, modelKey: "galaxys3"),
//        Product(color: "White s3", formattedPrice: "$299.99", family: "Pixel 2", rating: 3.4, modelKey: "galaxys3"),
//    ]
}

