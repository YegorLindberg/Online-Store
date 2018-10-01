//
//  BaseDataProvider.swift
//  online-store
//
//  Created by Moore on 20.09.2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import Foundation

//TODO: declare protocol DataProviderDelegate
//dataProvider(_ dataProvider: BaseDataProvider, onItemsUpdated items: [..])

//protocol DataProviderDelegate {
//    <#requirements#>
//}

class BaseDataProvider {
    //items
    var items = [Any]()
    //TODO: rename to delegate
    var delegateProductsVC: ProductsViewController?
//    var delegate: DataProviderDelegate
    
    // (+) reloadData (clear data and call loadNextItems)
    func reloadData() {
        items = [] //clear data
        loadNextItems()
    }
    //loadNextItems - abstract, call API and call onItemsLoaded in API handler
    func loadNextItems() -> Bool {
        //TODO: add isLoading and isAllLoaded checking and settings
        return true
    }
    
    //onItemsLoaded (newItems), add newItems to items, call delegate
    func onItemsLoaded(_ newItems: [Any]) {
        //TODO: use self
        items += newItems
        //TODO: call delegate about new items
        //TODO: add isLoading and isAllLoaded settings
    }
}
