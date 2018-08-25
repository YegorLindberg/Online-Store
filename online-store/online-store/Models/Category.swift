//
//  Category.swift
//  online-store
//
//  Created by Moore on 25.08.2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import UIKit
import ObjectMapper

class Category: Mappable {
    
    var categoryId:          Int?
    var title:               String!
    var imageUrl:            String?
    var hasSubcategories:    Int?
    var fullName:            String?
    var categoryDescription: String!
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        categoryId          <- map["categoryId"]
        title               <- map["title"]
        imageUrl            <- map["imageUrl"]
        hasSubcategories    <- map["hasSubcategories"]
        fullName            <- map["fullName"]
        categoryDescription <- map["categoryDescription"]
    }
}
