//
//  CategoriesCollectionViewController.swift
//  online-store
//
//  Created by Moore on 22.08.2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var buttonMenu: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    private var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenu()
        customizeNavBar()
        
        let categoryApi = CategoryApi()
        categoryApi.loadCategories { (categories) in
            self.categories = categories
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func sideMenu() {
        if revealViewController() != nil {
            buttonMenu.target = revealViewController()
            buttonMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 275
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    func customizeNavBar() {
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        navigationBarAppearance.barTintColor = UIColor(red: 71/255, green: 209/255, blue: 255/255, alpha: 1)
    }
    
}


extension CategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
        let category = self.categories[indexPath.row]
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        cell.labelCategoryName.text = category.title
        
        cell.categoryImageView.sd_setImage(with: URL(string: ("\(category.imageUrl ?? "Empty Img")")), placeholderImage: UIImage(named: "emptyimg.png"))
        
        return cell
    }


}
