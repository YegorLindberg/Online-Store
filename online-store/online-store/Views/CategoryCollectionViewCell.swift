//
//  CategoryCollectionViewCell.swift
//  online-store
//
//  Created by Moore on 22.08.2018.
//  Copyright © 2018 Moore. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var labelCategoryName: UILabel!
    
    func populate(category: Category) {
        labelCategoryName.text = category.title
        
        categoryImageView.sd_setImage(with: URL(string: ("\(category.imageUrl ?? "Empty Img")")), placeholderImage: UIImage(named: "emptyimg.png"))
    }
}
