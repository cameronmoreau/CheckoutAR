//
//  Api.swift
//  ARShop
//
//  Created by Cameron Moreau on 10/22/17.
//  Copyright © 2017 cameronmoreau. All rights reserved.
//

import SwiftyJSON
import Alamofire
import MapKit

class Api {
    let BASEURL = "https://vedgwwprd3.execute-api.us-east-1.amazonaws.com/dev/arshop/prac3"
    
    func checkoutOrder(price: String, latittude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping () -> Void) {
        Alamofire.request("\(self.BASEURL)?api=sms&cost=\(price)&lat=\(latittude)&lng=\(longitude)").responseJSON { response in
            completion()
        }
    }
    
    func getProducts(completion: @escaping ([Product]?) -> Void) {
        Alamofire.request("\(self.BASEURL)?api=productList").responseJSON { response in
            
            if let json = response.result.value {
                let data = JSON(json)
                var products = [Product]()
                
                for item in data["data"].arrayValue {
                    let product = Product(json: item)
                    products.append(product)
                }
                
                completion(products)
            } else {
                completion(nil)
            }
        }
    }
    
    func getTMobileStores(completion: @escaping ([Place]?) -> Void) {
        Alamofire.request("\(self.BASEURL)?api=locations").responseJSON { response in
            
            if let json = response.result.value {
                let data = JSON(json)
                var places = [Place]()
                
                for item in data["data"]["results"].arrayValue {
                    let place = Place(json: item)
                    places.append(place)
                }
                
                completion(places)
            } else {
                completion(nil)
            }
        }
    }
}
