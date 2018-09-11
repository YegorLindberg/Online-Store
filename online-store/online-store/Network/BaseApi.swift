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

class BaseApi {
    
    func sendRequest(page: Int, relativeUrl: String, params: [String: Any]?, handler: @escaping (Any) -> Void) {
        var absoluteUrl = prepareUrl(relativeUrl: relativeUrl)
        let resultParams = prepareParams(page: page, params: params, absoluteUrl: &absoluteUrl) //Add app key here
        Alamofire.request(absoluteUrl, parameters:resultParams).responseJSON { response in
            if let json = response.result.value {
                let jsonObject = json as! Dictionary<String, Any>
                let metaObject = jsonObject["meta"] as! Dictionary<String, Any>
                let success = metaObject["success"] as! Bool
                if  success == true {
                    let dataObject = jsonObject["data"];
                    handler(dataObject as Any)
                } else {
                    let error = metaObject["error"] as! String
                    print(error)
                }
                
            }
        }
    }
    
    func prepareUrl(relativeUrl: String) -> String {
        return "http://onlinestore.whitetigersoft.ru/api/" + relativeUrl + "?appKey=";
    }
    
    func prepareParams(page: Int, params: [String: Any]?, absoluteUrl: inout String) -> [String: Any]? {
        let appKey = "yx-1PU73oUj6gfk0hNyrNUwhWnmBRld7-SfKAU7Kg6Fpp43anR261KDiQ-MY4P2SRwH_cd4Py1OCY5jpPnY_Viyzja-s18njTLc0E7XcZFwwvi32zX-B91Sdwq1KeZ7m"
        if page > 0 {
            let countOfProductsOnPage = 15
            let productCount = page * countOfProductsOnPage
            absoluteUrl = absoluteUrl + appKey + "&offset=\(productCount)"
        } else {
            absoluteUrl += appKey
        }
        return params
    }
    
}
