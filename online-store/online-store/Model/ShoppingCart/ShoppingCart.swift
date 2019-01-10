//
//  ShoppingCart.swift
//  online-store
//
//  Created by Yegor Lindberg on 04/12/2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import UIKit
import ObjectMapper

class ShoppingCart: NSObject, Codable {
    
    var shoppingCartItems = [ShoppingCartItem]()
    
    func addProduct(product: Product) {
        if let index = shoppingCartItems.index(where: {$0.product.productId == product.productId}) {
            shoppingCartItems[index].addOneItem()
        } else {            
            shoppingCartItems.append(ShoppingCartItem(product))
        }
    }
    
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
        var productsCount = 0
        for product in shoppingCartItems {
            productsCount += product.productCount
        }
        return productsCount
    }
    
    func saveShoppingCart() {
        do {
            let someItems = try JSONEncoder().encode(shoppingCartItems)
            UserDefaults.standard.setValue(someItems, forKey: "items")
        } catch let error {
            print("Error: ", error)
        }
        
    }
    
    func loadData() {
        guard let data = UserDefaults.standard.object(forKey: "items") as? Data else {
            return
        }
        do {
            let someItems = try JSONDecoder().decode([ShoppingCartItem].self, from: data)
            if someItems.count > 0 {
                print(someItems[0].product.title)
                self.shoppingCartItems = someItems
            } else {
                print("someItems have 0 elements.")
            }
        } catch let error {
            print("Error: ", error)
        }

    }

    
}
