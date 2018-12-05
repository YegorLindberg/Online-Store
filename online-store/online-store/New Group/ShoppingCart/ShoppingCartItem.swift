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
    var countOfProduct: Int!
    
    func addCartItem(product: Product) {
        self.product = product
        countOfProduct = 1
    }
    func addOneItem() {
        self.countOfProduct += 1
    }
    func removeOneItem() {
        self.countOfProduct -= 1
    }    
    
}
