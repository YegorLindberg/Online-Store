//
//  NetWorker.swift
//  online-store
//
//  Created by Moore on 25.08.2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import Foundation
import CFNetwork
import Alamofire
import ObjectMapper

class ProductApi {

    private let productListURL = "http://onlinestore.whitetigersoft.ru/api/common/product/list?appKey="
    
    func loadProducts(relativeUrl: String, params: String, handler: @escaping ([Product]) -> Void) {
        let complitionURL = productListURL + relativeUrl
        Alamofire.request(complitionURL).responseJSON { response in
            if let json = response.result.value {
                let jsonObject = json as! Dictionary<String, Any>
                let metaObject = jsonObject["meta"] as! Dictionary<String, Any>
                
                let products = Mapper<Product>().mapArray(JSONArray: jsonObject["data"] as! [Dictionary<String, Any>])
                handler(products)
            }
        }
    }
    
}
