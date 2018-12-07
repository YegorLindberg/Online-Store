//
//  SingleProductViewController.swift
//  online-store
//
//  Created by Moore on 01.10.2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import UIKit
import SDWebImage

class SingleProductViewController: BaseViewController {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSideCartButton()
        self.productImageView.sd_setImage(with: URL(string: ("\(product.imageUrl ?? "Empty Img")")), placeholderImage: UIImage(named: "emptyimg.png"))
        self.labelProductName.text = product.title
        self.labelRating.text = (product.rating != nil) ? "Rating: \(product.rating as! Double)" : "Rating is missing"
        self.labelPrice.text = (product.price != nil) ? "Price: \(product.price as! Int)" : "Price is missing"
        self.labelDescription.text = "Description:" + ((product.productDescription != nil) ? product.productDescription : "is missing.")
    }
    

}
