//
//  ShoppingCart.swift
//  online-store
//
//  Created by Yegor Lindberg on 04/12/2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import UIKit

class ShoppingCart: NSObject, NSCoding {
    
    func encode(with aCoder: NSCoder) {
        //
    }
    
    required init?(coder aDecoder: NSCoder) {
//        self.shoppingCartItems = aDecoder.decodeObject(forKey: <#T##String#>)
    }
    
    
    //TODO: save array of ShoppingCartItem's
    var shoppingCartItems = [ShoppingCartItem]()
    
    //addProduct
    func addProduct(product: Product) {
        if let index = shoppingCartItems.index(where: {$0.product.productId == product.productId}) {
            shoppingCartItems[index].addOneItem()
        } else {            
            shoppingCartItems.append(ShoppingCartItem(product))
        }
    }
    
    //removeProduct
    func removeProduct(product: Product) -> Bool {
        if let index = shoppingCartItems.index(where: {$0.product.productId == product.productId}) {
            if shoppingCartItems[index].productCount == 1 {
                shoppingCartItems.remove(at: index)
            } else {
                shoppingCartItems[index].removeOneItem()
            }
            return true
        }
        return false
    }
    
    func countProductsInCart() -> Int {
        return shoppingCartItems.count
    }
    
    //save in UserDefaults
    
    //load from UserDefaults
    
    //use UserDefaults
    
    //serialize array to json or to xml via NSCoding

    
    
}
