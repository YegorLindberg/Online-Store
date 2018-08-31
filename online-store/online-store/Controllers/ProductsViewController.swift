//
//  AllProductsViewController.swift
//  online-store
//
//  Created by Moore on 15.08.2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import ObjectMapper

class ProductsViewController: UIViewController {

    @IBOutlet weak var buttonMenu: UIBarButtonItem!
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenu()
        customizeNavBar()

        let productApi = ProductApi()
        productApi.loadProducts { (products) in
            self.products = products
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
        //TODO: use UINavigationBar.appearance(), move AppDelegate
        //        UIApplication.shared.keyWindow?.rootViewController
        //        UIApplication.shared.delegate
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        navigationBarAppearance.barTintColor = UIColor(red: 71/255, green: 209/255, blue: 255/255, alpha: 1)
        
//        navigationBarAppearance.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
    }

}

extension ProductsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        let product = self.products[indexPath.row]
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        cell.labelNameProduct.text = product.title
        
        cell.labelRating.text = (product.rating != nil) ? "Rating: \(product.rating as! Double)" : "Rating is missing"
        
        cell.labelPrice.text = (product.price != nil) ? "Price: \(product.price as! Int)" : "Price is missing"
        
        cell.ImageViewProduct.sd_setImage(with: URL(string: ("\(product.imageUrl ?? "Empty Img")")), placeholderImage: UIImage(named: "emptyimg.png"))
        
        return cell
    }
}
