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

class ProductsViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private var refresher: UIRefreshControl!
    private var products   = [Product]()
    private let productApi = ProductApi()
    
    var category: Category?
    
    var productDataProvier = ProductDataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showActivityIndicator()
        self.productDataProvier.delegate = self
        self.productDataProvier.categoryId = self.category?.categoryId
        self.productDataProvier.reloadData()
        
        tryShowSideMenuButton()
        addRefresher()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showShoppingCartButton()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProduct" {
            if let selectedProduct = sender as? Product, let destinationViewController = segue.destination as? SingleProductViewController {
                destinationViewController.product = selectedProduct
            }
        }
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

extension ProductsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row > self.products.count - 5 {
            if self.productDataProvier.loadNextItems() {
                print("next products was loaded.")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        let product = self.products[indexPath.row]
        cell.populate(product: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        performSegue(withIdentifier: "showProduct", sender: product)
    }
}

extension ProductsViewController:  DataProviderDelegate {
    
    func dataProvider(_ dataProvider: BaseDataProvider, onItemsUpdated items: [Any]) {
        self.products = items as! [Product]
        print("products count: \(self.products.count)")
        self.collectionView?.reloadData()
        self.refresher?.endRefreshing()
        self.hideActivityIndicator()
    }
    
}
