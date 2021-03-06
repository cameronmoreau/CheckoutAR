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
    var modelKey: String
    
    init(json: JSON) {
        self.color = json["color"].stringValue
        self.formattedPrice = json["fullPrice"].stringValue
        self.sku = json["sku"].stringValue
        self.rating = json["rating"].doubleValue
        self.family = json["family"].stringValue
        self.status = json["invStatus"].stringValue
        self.modelKey = json["modelName"].stringValue
    }
    
    init(color: String, formattedPrice: String, family: String, rating: Double, modelKey: String) {
        self.color = color
        self.formattedPrice = formattedPrice
        self.family = family
        self.rating = rating
        self.modelKey = modelKey
    }
    
    func toPriceNumber() -> Double {
        let priceTextArr = self.formattedPrice!.split { $0 == "$"}
        if priceTextArr.isEmpty {
            return 0.0
        }
        if let price = Double(priceTextArr[0]) {
            return price
        }
        return 0.0
    }
}
