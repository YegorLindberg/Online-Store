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

class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var buttonMenu: UIBarButtonItem!
    @IBOutlet weak var CategoriesCollectionVeiw: UICollectionView!
    private var categoriesFromJSON = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CategoriesCollectionVeiw.dataSource = self
        CategoriesCollectionVeiw.delegate = self
        
        sideMenu()
        customizeNavBar()
        
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
                self.CategoriesCollectionVeiw?.reloadData()
            }
        }
        // Do any additional setup after loading the view.
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
        navigationController?.navigationBar.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(red: 71/255, green: 209/255, blue: 255/255, alpha: 1)
        //        navigationController?.navigationBar.titleTextAttributes = [: UIColor.white]
    }
    
}


extension CategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.categoriesFromJSON.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
        let category = self.categoriesFromJSON[indexPath.row]
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        cell.labelCategoryName.text = category.title
        
        cell.categoryImageView.sd_setImage(with: URL(string: ("\(category.imageUrl ?? "Empty Img")")), placeholderImage: UIImage(named: "emptyimg.png"))
        
        return cell
    }


}
