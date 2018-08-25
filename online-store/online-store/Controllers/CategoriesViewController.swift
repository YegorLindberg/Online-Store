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

private let reuseIdentifier = "Cell"

class CategoriesViewController: UICollectionViewController {
    
    private var categoriesFromJSON = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        Alamofire.request("http://82.146.53.185:8101/api/common/category/list?appKey=yx-1PU73oUj6gfk0hNyrNUwhWnmBRld7-SfKAU7Kg6Fpp43anR261KDiQ-MY4P2SRwH_cd4Py1OCY5jpPnY_Viyzja-s18njTLc0E7XcZFwwvi32zX-B91Sdwq1KeZ7m").responseJSON { response in
            
            if let json = response.result.value {
                let jsonObject = json as! Dictionary<String, Any>
                let metaObject = jsonObject["meta"] as! Dictionary<String, Any>
                let dataObject = jsonObject["data"] as! Dictionary<String, Any>
                let categories = dataObject["categories"] as! [Dictionary<String, Any>]
                
                self.categoriesFromJSON = Mapper<Category>().mapArray(JSONArray: categories)
                print("success categories: \(String(describing: metaObject["success"]))")
                print("dataObject: \(self.categoriesFromJSON[0].title)\n\n")
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

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.categoriesFromJSON.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
        let category = self.categoriesFromJSON[indexPath.row]
    
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        cell.LabelCategoryName.text = category.title
        
        cell.ImageViewCategory.sd_setImage(with: URL(string: ("\(category.imageUrl ?? "Empty Img")")), placeholderImage: UIImage(named: "emptyimg.png"))
    
        return cell
    }

    // MARK: UICollectionViewDelegate

}

