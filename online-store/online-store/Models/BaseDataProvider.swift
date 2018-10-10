//
//  BaseDataProvider.swift
//  online-store
//
//  Created by Moore on 20.09.2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import Foundation

protocol DataProviderDelegate {
    func dataProvider(_ dataProvider: BaseDataProvider, onItemsUpdated items: [Any])
}

class BaseDataProvider {
    
    var delegate: DataProviderDelegate?
    var isLoading   = false
    var isAllLoaded = false
    var items       = [Any]()
    
    func reloadData() {
        self.items = []
        self.isAllLoaded = false
        loadNextItems()
    }
    //loadNextItems - abstract, call API and call onItemsLoaded in API handler
    func loadNextItems() -> Bool {
        if self.isLoading || self.isAllLoaded {
            return false
        }
        self.isLoading = true
        return true
    }
    
    //onItemsLoaded (newItems), add newItems to items, call delegate
    func onItemsLoaded(_ newItems: [Any]) {
        if newItems.count == 0 {
            self.isAllLoaded = true
        } else {
            self.items += newItems
        }
        self.isLoading = false
        delegate?.dataProvider(self, onItemsUpdated: self.items)
    }
    
}
