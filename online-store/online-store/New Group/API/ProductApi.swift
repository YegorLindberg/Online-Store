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
    
    func loadProducts(offset: Int?, categoryId: Int?, handler: @escaping ([Product]) -> Void) {
        let params = [
                        "offset"    : offset ?? 0,
                        "categoryId": categoryId ?? 0,
                     ]
        sendRequest(relativeUrl: productListURL, params: params) { (data) in
            let products = Mapper<Product>().mapArray(JSONArray: data as! [Dictionary<String, Any>])
            handler(products)
        }
    }
    
}
