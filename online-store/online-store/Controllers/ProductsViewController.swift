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

    @IBOutlet weak var collectionView: UICollectionView!
    private var refresher: UIRefreshControl!
    private var products   = [Product]()
    private let productApi = ProductApi()
    
    var categoryId: Int?
    
    var productDataProvier = ProductDataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productDataProvier.delegate = self
        productDataProvier.reloadData()
        
        let arrayOfVC = navigationController?.viewControllers
        print("count of vc:\(String(describing: arrayOfVC?.count))")
        
        if arrayOfVC?.count == 1 {
            sideMenu()
        }
        
        addRefresher()
        reloadData()

    }
    
    func addRefresher() {
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: #selector(ProductsViewController.reloadData), for: UIControlEvents.valueChanged)
        collectionView.addSubview(refresher)
    }
    
    @objc func reloadData() {
        productDataProvier.reloadData()
        print("reload data: products")
    }
    
    func sideMenu() {
        if revealViewController() != nil {
            let menuButton = UIBarButtonItem(title: "Menu",
                                             style: .done,
                                             target: revealViewController(),
                                             action: #selector(SWRevealViewController.revealToggle(_:)))
            revealViewController().rearViewRevealWidth = 275
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.navigationItem.leftBarButtonItem = menuButton
        }
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
            productDataProvier.loadNextItems()
        }
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
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
            self.refresher?.endRefreshing()
        }
    }
    
}
