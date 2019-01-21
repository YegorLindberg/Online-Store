//
//  CartTableViewCell.swift
//  online-store
//
//  Created by Yegor Lindberg on 09/12/2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import UIKit

protocol ShoppingCartCellDelegate: class {
    func didPressPlus(_ sender: UIButton)
    func didPressMinus(_ sender: UIButton)
}

class ShoppingCartTableViewCell: UITableViewCell {
    
    weak var cellDelegate: ShoppingCartCellDelegate?
    
    @IBOutlet weak var titleProductLabel: UILabel!
    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var priceProductLabel: UILabel!
    @IBOutlet weak var countProductLabel: UILabel!
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        cellDelegate?.didPressPlus(sender)
    }
    
    @IBAction func removeButtonTapped(_ sender: UIButton) {
        cellDelegate?.didPressMinus(sender)
    }
    
    func populate(with productItem: ShoppingCartItem) {        
        self.titleProductLabel.text = productItem.product.title
        self.imageViewProduct.sd_setImage(with: URL(string: ("\(productItem.product.imageUrl ?? "Empty Img")")), placeholderImage: UIImage(named: "emptyimg.png"))
        if productItem.product.price == nil {
            priceProductLabel.text = "is missing"
        } else {
            priceProductLabel.text = String(productItem.product.price!) + "$"
        }
        countProductLabel.text = String(productItem.productCount)        
    }
        
}
