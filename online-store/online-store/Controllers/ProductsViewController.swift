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
    private var refresher: UIRefreshControl!
    private var products = [Product]()
    private let productApi = ProductApi()
    private var currentPage = 0
    
    var isLoading = false
    var isAllLoaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenu()
        
        downloadStartData()
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: #selector(ProductsViewController.downloadStartData), for: UIControlEvents.valueChanged)
        collectionView.addSubview(refresher)
        
    }
    
    @objc func downloadStartData() {
        currentPage = 0
        isAllLoaded = false
        isLoading = true
        productApi.loadProducts(page: 0, params: nil, handler: { (products) in
            self.products = products
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
                print("view products")
                self.isLoading = false
                self.refresher?.endRefreshing()
            }
        })
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if ((indexPath.row > self.products.count - 5) && !isLoading && !isAllLoaded) {
            isLoading = true
            print("indexPath.row >")
            currentPage += 1
            productApi.loadProducts(page: currentPage, params: nil) { (products) in
                if products.count == 0 {
                    self.isAllLoaded = true
                    print("all is loaded, last page is: \(self.currentPage - 1)")
                } else {
                    self.products += products
                }
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                    print("view products with loaded page \(self.currentPage)")
                    self.isLoading = false
                }
            }
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
}
