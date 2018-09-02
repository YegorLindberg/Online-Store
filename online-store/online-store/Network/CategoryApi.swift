//
//  CategoryApi.swift
//  online-store
//
//  Created by Moore on 31.08.2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import Foundation
import CFNetwork
import Alamofire
import ObjectMapper

class CategoryApi {
    
    private let categoryListURL = "http://82.146.53.185:8101/api/common/category/list?appKey="
    
    func loadCategories(relativeUrl: String, params: String, handler: @escaping ([Category]) -> Void) {
        let complitionURL = categoryListURL + relativeUrl
        Alamofire.request(complitionURL).responseJSON { response in
            if let json = response.result.value {
                let jsonObject = json as! Dictionary<String, Any>
                let metaObject = jsonObject["meta"] as! Dictionary<String, Any>
                let dataObject = jsonObject["data"] as! Dictionary<String, Any>
                
                let categories = Mapper<Category>().mapArray(JSONArray: dataObject["categories"] as! [Dictionary<String, Any>])
                handler(categories)
            }
        }
    }
    
}
