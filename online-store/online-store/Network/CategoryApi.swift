//
//  CategoryApi.swift
//  online-store
//
//  Created by Moore on 31.08.2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import Foundation
import ObjectMapper

class CategoryApi: BaseApi {
    
    private let categoryListURL = "common/category/list"
    
    func loadCategories(params: [String: Any]?, handler: @escaping ([Category]) -> Void) {
        sendRequest(relativeUrl: categoryListURL, params: params) { (data) in
            let dataObject = data as! Dictionary<String, Any>
            let categories = Mapper<Category>().mapArray(JSONArray: dataObject["categories"] as! [Dictionary<String, Any>])
            handler(categories)
        }
    }
    
}
