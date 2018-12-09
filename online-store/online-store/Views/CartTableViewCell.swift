//
//  CartTableViewCell.swift
//  online-store
//
//  Created by Yegor Lindberg on 09/12/2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var titleProductLabel: UILabel!
    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var priceProductLabel: UILabel!
    @IBOutlet weak var countProductLabel: UILabel!
    
    func populate(with productItem: ShoppingCartItem) {
        titleProductLabel.text = productItem.product.title
        imageViewProduct.sd_setImage(with: URL(string: ("\(productItem.product.imageUrl ?? "Empty Img")")), placeholderImage: UIImage(named: "emptyimg.png"))
        if productItem.product.price == nil {
            priceProductLabel.text = "is missing"
        } else {
            priceProductLabel.text = String(productItem.product.price!)
        }
        countProductLabel.text = String(productItem.productCount)
    }
    
    
}
