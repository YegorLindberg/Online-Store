//
//  CategoriesCollectionViewController.swift
//  online-store
//
//  Created by Moore on 22.08.2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import UIKit
import Alamofire

private let reuseIdentifier = "Cell"

class CategoriesViewController: UICollectionViewController {

    private var jsonObject: Dictionary<String, Any>!
    private var metaObject: Dictionary<String, Any>!
    private var dataObject: Dictionary<String, Any>!
    private var categoriesObject = [Dictionary<String, Any>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        Alamofire.request("http://82.146.53.185:8101/api/common/category/list?appKey=yx-1PU73oUj6gfk0hNyrNUwhWnmBRld7-SfKAU7Kg6Fpp43anR261KDiQ-MY4P2SRwH_cd4Py1OCY5jpPnY_Viyzja-s18njTLc0E7XcZFwwvi32zX-B91Sdwq1KeZ7m").responseJSON { response in
            
            if let json = response.result.value {
                self.jsonObject = json as! Dictionary<String, Any>
                self.metaObject = self.jsonObject["meta"] as! Dictionary<String, Any>
                self.dataObject = self.jsonObject["data"] as! Dictionary<String, Any>
                self.categoriesObject = self.dataObject["categories"] as! [Dictionary<String, Any>]
                //print("JSON: \(jsonObject)\n\n") // serialized json response
                print("metaObject: \(self.metaObject)\n\n")
                print("categoriesObject: \(self.categoriesObject[0])\n\n")
            }
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        

    // MARK: - Navigation


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return categoriesObject.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
    
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        cell.LabelCategoryName.text = (categoriesObject[indexPath.row]["title"] as! String)
        
        if (categoriesObject[indexPath.row]["imageUrl"] as? NSNull) != nil {
            cell.ImageViewCategory.image = #imageLiteral(resourceName: "emptyimg")
        } else {
            
            Alamofire.request(categoriesObject[indexPath.row]["imageUrl"] as! String).responseData { (response) in
                print(response.result)
                print(response.result.value as Any)
                
                if let data = response.result.value {
                    cell.ImageViewCategory.image = UIImage(data: data)
                }
            }
        }
        
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

}

