//
//  ProductCollectionViewCell.swift
//  online-store
//
//  Created by Moore on 15.08.2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ImageViewProduct: UIImageView!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var labelNameProduct: UILabel!
    @IBOutlet weak var labelPrice: UILabel!

    func populate(product: Product) {
        labelNameProduct.text = product.title
        
        labelRating.text = (product.rating != nil) ? "Rating: \(product.rating as! Double)" : "Rating is missing"
        
        labelPrice.text = (product.price != nil) ? "Price: \(product.price as! Int)" : "Price is missing"
        
        ImageViewProduct.sd_setImage(with: URL(string: ("\(product.imageUrl ?? "Empty Img")")), placeholderImage: UIImage(named: "emptyimg.png"))
    }
    
}
