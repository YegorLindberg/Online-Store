//
//  ShoppingCartItem.swift
//  online-store
//
//  Created by Yegor Lindberg on 04/12/2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import UIKit

class ShoppingCartItem: NSObject {
    //TODO: add Product
    var product: Product!
    //TODO: add count
    var productCount = 1
    
    init (_ product: Product) {
        self.product = product        
    }
    
    func addOneItem() {
        self.productCount += 1
    }
    func removeOneItem() {
        self.productCount -= 1
    }    
    
}
