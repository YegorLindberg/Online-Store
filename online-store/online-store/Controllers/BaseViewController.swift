//
//  BaseViewController.swift
//  online-store
//
//  Created by Moore on 11.10.2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

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

    func showSideCartButton() {
        let cartButton = UIBarButtonItem(title: "Cart",
                                         style: .done,
                                         target: self,
                                         action: #selector(showCartView))
        //        self.view.addGestureRecognizer()
        self.navigationItem.rightBarButtonItem = cartButton
        
    }
    
    @objc func showCartView() {
        //segue
        let cartViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CartScreen") as! CartViewController
        self.navigationController?.pushViewController(cartViewController, animated: true)
        print("Cart activate")
    }
    
}
