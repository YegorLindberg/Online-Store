//
//  App.swift
//  online-store
//
//  Created by Yegor Lindberg on 06/12/2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import UIKit

class App: NSObject {
    
    //TODO: add product api and category api
    var productApi = ProductApi()
    var categoryApi = CategoryApi()
    
    //TODO: ShoppingCart
    var shoppingCart = ShoppingCart()
    
    //TODO: add singleton method instance
    static let appManagement = App()
    private override init(){}
}


