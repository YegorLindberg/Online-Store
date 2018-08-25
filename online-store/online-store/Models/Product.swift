//
//  Product.swift
//  online-store
//
//  Created by Moore on 25.08.2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import UIKit
import ObjectMapper

class Product: Mappable {
    var productId:          Int?
    var title:              String!
    var productDescription: String!
    var price:              Int?
    var rating:             Double?
    var imageUrl:           String?
    var images:             [String]?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        productId          <- map["productId"]
        title              <- map["title"]
        productDescription <- map["productDescription"]
        price              <- map["price"]
        rating             <- map["rating"]
        imageUrl           <- map["imageUrl"]
        images             <- map["images"]
    }
}
