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

private let reuseIdentifier = "Cell"

class ProductsViewController: UICollectionViewController {

    private var productsFromJSON = [Product]()
    
    @IBAction func onMenuTapped() {
        print("TOGGLE SIDE MENU")
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showCategories),
                                               name: NSNotification.Name("ShowCategories"),
                                               object: nil)
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        Alamofire.request("http://onlinestore.whitetigersoft.ru/api/common/product/list?appKey=yx-1PU73oUj6gfk0hNyrNUwhWnmBRld7-SfKAU7Kg6Fpp43anR261KDiQ-MY4P2SRwH_cd4Py1OCY5jpPnY_Viyzja-s18njTLc0E7XcZFwwvi32zX-B91Sdwq1KeZ7m").responseJSON { response in

            if let json = response.result.value {
                let jsonObject = json as! Dictionary<String, Any>
                let metaObject = jsonObject["meta"] as! Dictionary<String, Any>
                let products = jsonObject["data"] as! [Dictionary<String, Any>]
                
                self.productsFromJSON = Mapper<Product>().mapArray(JSONArray: products)
                print("success products: \(String(describing: metaObject["success"]))")
                print("dataObject: \(self.productsFromJSON[0].title)\n\n")
            }
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
        
    }

    @objc func showCategories() {
        performSegue(withIdentifier: "ShowCategories", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.productsFromJSON.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        let product = self.productsFromJSON[indexPath.row]
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        cell.labelNameProduct.text = product.title
        
        if let ratingProduct = product.rating {
            cell.labelRating.text = "Rating: \(ratingProduct)"
        } else {
            cell.labelRating.text = "Rating is missing"
        }

        if let priceProduct = product.price {
            cell.labelPrice.text = "Price: \(priceProduct)"
        } else {
            cell.labelPrice.text = "Price is missing"
        }        

        cell.ImageViewProduct.sd_setImage(with: URL(string: ("\(product.imageUrl ?? "Empty Img")")), placeholderImage: UIImage(named: "emptyimg.png"))
    
        return cell
    }

    // MARK: UICollectionViewDelegate

}
