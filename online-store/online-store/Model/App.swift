//
//  App.swift
//  online-store
//
//  Created by Yegor Lindberg on 06/12/2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import UIKit

class App: NSObject {
    
    var productApi = ProductApi()
    var categoryApi = CategoryApi()
    
    var shoppingCart = ShoppingCart()
        
    static let appManagement = App()
    private override init(){}
    
    
}


