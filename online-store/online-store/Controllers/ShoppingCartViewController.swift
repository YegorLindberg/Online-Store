//
//  CartViewController.swift
//  online-store
//
//  Created by Yegor Lindberg on 06/12/2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import UIKit

class ShoppingCartViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var shoppingCartItems: [ShoppingCartItem]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Cart"
        tableView.delegate = self
        tableView.dataSource = self
        print(shoppingCartItems.count, " cart items count")
        self.navigationController?.title = "Cart"
    }
    
}


extension ShoppingCartViewController: UITableViewDataSource, UITableViewDelegate, ShoppingCartCellDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shoppingCartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableCell") as! ShoppingCartTableViewCell
        let productItem = shoppingCartItems[indexPath.row]
        cell.cellDelegate = self
        cell.populate(with: productItem)
        return cell
    }

    func didPressPlus(_ sender: UIButton) {
        if let indexPath = getCurrentCellIndexPath(sender) {
            App.appManagement.shoppingCart.addProduct(product: shoppingCartItems[indexPath.row].product)
            self.shoppingCartItems = App.appManagement.shoppingCart.shoppingCartItems
            tableView.reloadData()
        }
    }
    
    func didPressMinus(_ sender: UIButton) {
        if let indexPath = getCurrentCellIndexPath(sender) {
            if (App.appManagement.shoppingCart.removeProduct(product: shoppingCartItems[indexPath.row].product)) {
                self.shoppingCartItems = App.appManagement.shoppingCart.shoppingCartItems
                tableView.reloadData()
            }
        }
    }
    
    func getCurrentCellIndexPath(_ sender: UIButton) -> IndexPath? {
        let buttonPosition = sender.convert(CGPoint.zero, to: tableView)
        if let indexPath: IndexPath = tableView.indexPathForRow(at: buttonPosition) {
            return indexPath
        }
        return nil
    }

    
}
