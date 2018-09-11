//
//  NetWorker.swift
//  online-store
//
//  Created by Moore on 25.08.2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import Foundation
import ObjectMapper

class ProductApi : BaseApi {

    private let productListURL = "common/product/list"
    
    func loadProducts(page: Int, params: [String: Any]?, handler: @escaping ([Product]) -> Void) {
        sendRequest(page: page, relativeUrl: productListURL, params: params) { (data) in
            let products = Mapper<Product>().mapArray(JSONArray: data as! [Dictionary<String, Any>])
            handler(products)
        }
    }
    
}
