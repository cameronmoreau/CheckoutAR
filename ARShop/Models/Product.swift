//
//  Product.swift
//  ARShop
//
//  Created by Cameron Moreau on 10/21/17.
//  Copyright © 2017 cameronmoreau. All rights reserved.
//

import SwiftyJSON

class Product {
    var color: String?
    var formattedPrice: String?
    var sku: String?
    var rating: Double?
    var family: String?
    var status: String?
    
    init(json: JSON) {
        self.color = json["color"].stringValue
        self.formattedPrice = json["fullPrice"].stringValue
        self.sku = json["sku"].stringValue
        self.rating = json["rating"].doubleValue
        self.family = json["family"].stringValue
        self.status = json["invStatus"].stringValue
    }
    
    init(color: String, formattedPrice: String, family: String, rating: Double) {
        self.color = color
        self.formattedPrice = formattedPrice
        self.family = family
        self.rating = rating
    }
}
