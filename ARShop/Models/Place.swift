//
//  Place.swift
//  ARShop
//
//  Created by Cameron Moreau on 10/22/17.
//  Copyright © 2017 cameronmoreau. All rights reserved.
//

import MapKit
import SwiftyJSON

class Place {
    var location: CLLocation?
    var link: String?
    var address: String?
    var dist: CLLocationDistance?
    
    init(json: JSON) {
        
        let currentLocation = CLLocation(latitude: 32.993959, longitude: -96.752156)
        
        let loc = json["geometry"]["location"]
        self.location = CLLocation(latitude: loc["lat"].doubleValue, longitude: loc["lng"].doubleValue)
        self.link = json["link"].stringValue
        self.address = json["vicinity"].stringValue
        self.dist = currentLocation.distance(from: self.location!)
    }
}
