//
//  BaseViewController.swift
//  online-store
//
//  Created by Moore on 11.10.2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {

    var hud = MBProgressHUD()
    
    func showActivityIndicator() {
        self.hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        self.hud.label.text = "Loading..."
        self.view.addSubview(hud)
    }
    
    func hideActivityIndicator() {
        self.hud.hide(animated: true)
    }

    func tryShowSideMenuButton() {
        if (revealViewController() != nil) && (navigationController?.viewControllers.count == 1) {
            let menuButton = UIBarButtonItem(title: "Menu",
                                             style: .done,
                                             target: revealViewController(),
                                             action: #selector(SWRevealViewController.revealToggle(_:)))
            revealViewController().rearViewRevealWidth = 275
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.navigationItem.leftBarButtonItem = menuButton
        }
    }
    
    func showShoppingCartButton() {        
        let cartButton = UIBarButtonItem(title: "Cart (\(App.appManagement.shoppingCart.countProductsInCart()))",
                                         style: .done,
                                         target: self,
                                         action: #selector(openShoppingCartController))
        self.navigationItem.rightBarButtonItem = cartButton
    }
    
    @objc func openShoppingCartController() {
        let cartViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CartScreen") as! ShoppingCartViewController
        cartViewController.shoppingCartItems = App.appManagement.shoppingCart.shoppingCartItems
        self.navigationController?.pushViewController(cartViewController, animated: true)
        print("Cart activate")
    }
    
}
