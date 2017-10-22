//
//  Api.swift
//  ARShop
//
//  Created by Cameron Moreau on 10/22/17.
//  Copyright © 2017 cameronmoreau. All rights reserved.
//

import SwiftyJSON
import Alamofire

class Api {
    
    func getProducts(completion: @escaping ([Product]?) -> Void) {
        Alamofire.request("https://vedgwwprd3.execute-api.us-east-1.amazonaws.com/dev/arshop/prac3?api=productList").responseJSON { response in
            
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
}
