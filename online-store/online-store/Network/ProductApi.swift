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
    //TODO: extends from BaseApi
//     sendRequest(relativeUrl, params, handler)
    
    func loadProducts(handler: @escaping ([Product]) -> Void) {
        Alamofire.request("http://onlinestore.whitetigersoft.ru/api/common/product/list?appKey=yx-1PU73oUj6gfk0hNyrNUwhWnmBRld7-SfKAU7Kg6Fpp43anR261KDiQ-MY4P2SRwH_cd4Py1OCY5jpPnY_Viyzja-s18njTLc0E7XcZFwwvi32zX-B91Sdwq1KeZ7m").responseJSON { response in
            
            if let json = response.result.value {
                let jsonObject = json as! Dictionary<String, Any>
                let metaObject = jsonObject["meta"] as! Dictionary<String, Any>
                
                let products = Mapper<Product>().mapArray(JSONArray: jsonObject["data"] as! [Dictionary<String, Any>])
                handler(products)
            }
        }
    }
}
