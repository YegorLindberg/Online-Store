//
//  CategoriesCollectionViewController.swift
//  online-store
//
//  Created by Moore on 22.08.2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import ObjectMapper

class CategoriesViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var categories  = [Category]()
    private let categoryApi = CategoryApi()
    
    var category: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.category?.fullName == nil ? (self.title = "Categories") : (self.title = self.category!.fullName)
        
        showActivityIndicator()
        tryShowSideMenuButton()

        self.categoryApi.loadCategories(categoryId: category?.categoryId) { (categories) in
            self.categories = categories
//            print("categories, is main thread: ", Thread.isMainThread) // (true)
            self.collectionView?.reloadData()
            print("view categories")
            self.hideActivityIndicator()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
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
        cell.populate(category: category)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        if category.hasSubcategories != 0 {
            let categoryViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CategoryScreen") as! CategoriesViewController
            categoryViewController.category = category
            self.navigationController?.pushViewController(categoryViewController, animated: true)
        } else {
            performSegue(withIdentifier: "ShowProducts", sender: category)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowProducts" {
            if let selectedCategory = sender as? Category, let destinationViewController = segue.destination as? ProductsViewController {
                destinationViewController.category = selectedCategory
            }
        }
    }    
    
    
}
