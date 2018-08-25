//
//  ContainerViewController.swift
//  online-store
//
//  Created by Moore on 20.08.2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!

    var sideMenuOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(toggleSideMenu),
                                               name: NSNotification.Name("ToggleSideMenu"),
                                               object: nil)
        
    }
    
    @objc func toggleSideMenu() {
        if sideMenuOpen {
            sideMenuOpen = false
            sideMenuConstraint.constant = -240
        } else {
            sideMenuOpen = true
            sideMenuConstraint.constant = 0
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

}
