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

//TODO: show HUD on data loading, use MBProgressHud
class ProductsViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private var refresher: UIRefreshControl!
    private var products   = [Product]()
    private let productApi = ProductApi()
    
    var categoryId: Int?
    
    var productDataProvier = ProductDataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.productDataProvier.delegate = self
        self.productDataProvier.categoryId = self.categoryId
        self.productDataProvier.reloadData()        
        
        tryShowSideMenuButton()
        showSideCartButton()
        addRefresher()

    }
    
    func addRefresher() {
        self.refresher = UIRefreshControl()
        self.refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refresher.addTarget(self, action: #selector(ProductsViewController.reloadData), for: UIControlEvents.valueChanged)
        self.collectionView.addSubview(refresher)
    }
    
    @objc func reloadData() {
        self.productDataProvier.reloadData()
        print("reload data: products")
    }

}


extension ProductsViewController: UICollectionViewDataSource, UICollectionViewDelegate, DataProviderDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row > self.products.count - 5 {
            self.productDataProvier.loadNextItems()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        let product = self.products[indexPath.row]
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        cell.populate(product: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        performSegue(withIdentifier: "showProduct", sender: product)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProduct" {
            if let selectedProduct = sender as? Product, let destinationViewController = segue.destination as? SingleProductViewController {
                destinationViewController.product = selectedProduct
            }
        }
    }
    
    func dataProvider(_ dataProvider: BaseDataProvider, onItemsUpdated items: [Any]) {
        self.products = items as! [Product]
        print("products count: \(self.products.count)")
        //TODO: check queue, try to delete DispatchQueue.main.async
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
            self.refresher?.endRefreshing()
        }
    }
    
}
