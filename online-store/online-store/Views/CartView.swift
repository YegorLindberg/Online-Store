//
//  CartView.swift
//  online-store
//
//  Created by Yegor Lindberg on 11/01/2019.
//  Copyright © 2019 Moore. All rights reserved.
//

import UIKit

class CollectionCellView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBInspectable public var borderWidth: CGFloat = 1.0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
        }
    }

    //TODO: add borderColor support
}
