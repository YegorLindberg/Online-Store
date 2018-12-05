//
//  ShoppingCart.swift
//  online-store
//
//  Created by Yegor Lindberg on 04/12/2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import UIKit

class ShoppingCart: NSObject {        
    
    //TODO: save array of ShoppingCartItem's
    var shoppingCartItems = [ShoppingCartItem]()
    
    //addProduct
    func addProduct(product: ShoppingCartItem) {
        if let index = shoppingCartItems.index(where: {$0.product.productId == product.product.productId}) {
            shoppingCartItems[index].addOneItem()
        } else {
            shoppingCartItems.append(product)
        }
    }
    
    //removeProduct
    func removeProduct(product: ShoppingCartItem) -> Bool {
        if let index = shoppingCartItems.index(where: {$0.product.productId == product.product.productId}) {
            if shoppingCartItems[index].countOfProduct == 1 {
                shoppingCartItems.remove(at: index)
            } else {
                shoppingCartItems[index].removeOneItem()
            }
            return true
        }
        return false
    }
    
    func countProductsInCart() {
        
    }
    
    //save
    //load
    //use UserDefaults
    //serialize to json or to xml via NSCoding
}
