//
//  CartViewController.swift
//  online-store
//
//  Created by Yegor Lindberg on 06/12/2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import UIKit

class CartViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var cartItems: [ShoppingCartItem]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Cart"
        tableView.delegate = self
        tableView.dataSource = self
        print(cartItems.count, " cart items count")
        self.navigationController?.title = "Cart"
    }
    
}


extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableCell") as! CartTableViewCell
        let productItem = cartItems[indexPath.row]
        cell.populate(with: productItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(110)
    }
    
    
}
