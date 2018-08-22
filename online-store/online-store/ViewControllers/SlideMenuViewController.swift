//
//  SideMenuViewController.swift
//  online-store
//
//  Created by Moore on 20.08.2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import UIKit

class SlideMenuViewController: UITableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
        print(indexPath.row)
        switch indexPath.row {
        case 0: NotificationCenter.default.post(name: NSNotification.Name("ShowCategories"), object: nil)
        case 1: NotificationCenter.default.post(name: NSNotification.Name("ShowCategories"), object: nil)
        default: break
        }
    }

}
