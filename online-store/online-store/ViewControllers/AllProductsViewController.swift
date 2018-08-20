//
//  AllProductsViewController.swift
//  online-store
//
//  Created by Moore on 15.08.2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import UIKit
import Alamofire

private let reuseIdentifier = "Cell"

class AllProductsViewController: UICollectionViewController {

    private var jsonObject: Dictionary<String, Any>!
    private var metaObject: Dictionary<String, Any>!
    private var dataObject = [Dictionary<String, Any>]()
    
    @IBAction func onMenuTapped() {
        print("TOGGLE SIDE MENU")
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        Alamofire.request("http://onlinestore.whitetigersoft.ru/api/common/product/list?appKey=yx-1PU73oUj6gfk0hNyrNUwhWnmBRld7-SfKAU7Kg6Fpp43anR261KDiQ-MY4P2SRwH_cd4Py1OCY5jpPnY_Viyzja-s18njTLc0E7XcZFwwvi32zX-B91Sdwq1KeZ7m").responseJSON { response in

            if let json = response.result.value {
                self.jsonObject = json as! Dictionary<String, Any>
                self.metaObject = self.jsonObject["meta"] as! Dictionary<String, Any>
                self.dataObject = self.jsonObject["data"] as! [Dictionary<String, Any>] //TODO: Словарь в NSArray
                //print("JSON: \(jsonObject)\n\n") // serialized json response
                print("metaObject: \(self.metaObject)\n\n")
                print("dataObject: \(self.dataObject[0])\n\n")
            }
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
//            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                print("Data: \(utf8Text)") // original server data as UTF8 string
//            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return dataObject.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        cell.labelNameProduct.text = (dataObject[indexPath.row]["title"] as! String)
        
        if (dataObject[indexPath.row]["rating"] as? NSNull) != nil {
            cell.labelRating.text = "Rating is missing"
//            print("\(String(describing: dataObject[indexPath.row]["title"])) with rating\(ratingProduct)")
        } else {
            if let ratingProduct = dataObject[indexPath.row]["rating"] as? Double {
                cell.labelRating.text = "Rating: \(ratingProduct)"
            } else {
                cell.labelRating.text = "Rating is missing"
            }
        }
        
        if (dataObject[indexPath.row]["price"] as? NSNull) != nil {
            cell.labelPrice.text = "Price is missing"
        } else {
            if let priceProduct = dataObject[indexPath.row]["price"] as? Int {
                cell.labelPrice.text = "Price: \(priceProduct)"
            } else {
                cell.labelPrice.text = "Price is missing"
            }
        }
        if (dataObject[indexPath.row]["imageUrl"] as? NSNull) != nil {
            cell.ImageViewProduct.image = #imageLiteral(resourceName: "emptyimg")
        } else {
            
            Alamofire.request(dataObject[indexPath.row]["imageUrl"] as! String).responseData { (response) in
                print(response.result)
                print(response.result.value as Any)
                
                if let data = response.result.value {
                    cell.ImageViewProduct.image = UIImage(data: data)
                }
            }
        }
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
