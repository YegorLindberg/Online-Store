//
//  BaseApi.swift
//  online-store
//
//  Created by Moore on 02.09.2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import Foundation
import CFNetwork
import Alamofire
import ObjectMapper

class BaseApi {
    
    private var productApi = ProductApi()
    private var categoryApi = CategoryApi()
    
    func sendRequestToLoadProducts(handler: @escaping ([Product]) -> Void) {
        let relativeURL = "yx-1PU73oUj6gfk0hNyrNUwhWnmBRld7-SfKAU7Kg6Fpp43anR261KDiQ-MY4P2SRwH_cd4Py1OCY5jpPnY_Viyzja-s18njTLc0E7XcZFwwvi32zX-B91Sdwq1KeZ7m"
        productApi.loadProducts(relativeUrl: relativeURL, params: "") { (products) in
            handler(products)
        }
    }
    
    func sendRequestToLoadCategories(handler: @escaping ([Category]) -> Void) {
        let relativeURL = "yx-1PU73oUj6gfk0hNyrNUwhWnmBRld7-SfKAU7Kg6Fpp43anR261KDiQ-MY4P2SRwH_cd4Py1OCY5jpPnY_Viyzja-s18njTLc0E7XcZFwwvi32zX-B91Sdwq1KeZ7m"
        categoryApi.loadCategories(relativeUrl: relativeURL, params: "") { (categories) in
            handler(categories)
        }
    }
    
}
