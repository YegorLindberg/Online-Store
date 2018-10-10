//
//  ProductDataProvider.swift
//  online-store
//
//  Created by Moore on 20.09.2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import Foundation

class ProductDataProvider : BaseDataProvider {
        
    var categoryId: Int?

    override func loadNextItems() -> Bool {
        if !super.loadNextItems() {
            return false
        }
        let productApi = ProductApi()
        productApi.loadProducts(offset: self.items.count, categoryId: nil) { (products) in
            self.onItemsLoaded(products)
        }
        return true
    }
}
